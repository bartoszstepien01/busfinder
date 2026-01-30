import 'dart:async';
import 'dart:convert';

import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/widgets/dialogs/error_dialog.dart';
import 'package:busfinder/widgets/common/loading_indicator.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:busfinder/services/osrm_service.dart';
import 'package:busfinder/widgets/common/bus_map.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  bool _isLoading = true;
  List<BusRouteResponseShortDto> _routes = [];
  BusRouteResponseShortDto? _selectedRoute;

  List<LatLng> _routePoints = [];
  List<LatLng> _stopsLocations = [];

  final MapController _mapController = MapController();

  final Map<String, Marker> _busMarkers = {};

  LatLng? _userLocation;
  StreamSubscription<Position>? _positionStream;

  dynamic _unsubscribeFn;

  @override
  void initState() {
    super.initState();

    _fetchRoutes();
    _startUserLocationTracking();
  }

  Future<void> _fetchRoutes() async {
    final api = context.read<ApiService>();
    final routesApi = BusRouteControllerApi(api.client);

    try {
      final response = await routesApi.getAllRoutes();
      if (response != null) {
        setState(() {
          _routes = response.data.toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _startUserLocationTracking() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    _positionStream = Geolocator.getPositionStream().listen((
      Position position,
    ) {
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
    });

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _onRouteSelected(BusRouteResponseShortDto? route) async {
    if (route == null) return;

    setState(() {
      _selectedRoute = route;
      _isLoading = true;
      _busMarkers.clear();
    });

    if (_unsubscribeFn != null) {
      _unsubscribeFn();
      _unsubscribeFn = null;
    }

    await _fetchRouteDetails(route.id);
    _subscribeToRoute(route.id);
    _subscribeToRoute('all');
  }

  Future<void> _fetchRouteDetails(String routeId) async {
    final api = context.read<ApiService>();
    final routesApi = BusRouteControllerApi(api.client);
    final stopsApi = BusStopControllerApi(api.client);

    try {
      final routeResponse = await routesApi.getRoute(routeId);
      final stopsResponse = await stopsApi.getAllBusStops();

      if (routeResponse?.data != null && stopsResponse?.data != null) {
        final route = routeResponse!.data!;
        final allStops = stopsResponse!.data;

        final standardVariant = route.variants.firstWhere(
          (v) => v.standard,
          orElse: () => route.variants.first,
        );

        final locations = standardVariant.busStops.map((stopId) {
          final stop = allStops.firstWhere((s) => s.id == stopId);
          return LatLng(stop.location.longitude!, stop.location.latitude!);
        }).toList();

        if (!mounted) return;
        final routePoints = await OsrmService.fetchRoute(locations);

        setState(() {
          _stopsLocations = locations;
          _routePoints = routePoints;
          _isLoading = false;
        });

        if (locations.isNotEmpty) {
          _mapController.fitCamera(
            CameraFit.bounds(
              bounds: LatLngBounds.fromPoints(locations),
              padding: const EdgeInsets.all(50),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _subscribeToRoute(String routeId) async {
    final stompClient = context.read<ApiService>().webSocketClient;
    final connected = context.read<ApiService>().webSocketClientConnected;

    if (!stompClient.connected) {
      stompClient.activate();
      await connected.future;
    }

    _unsubscribeFn = stompClient.subscribe(
      destination: '/route/$routeId',
      callback: (frame) {
        if (frame.body != null) {
          final data = jsonDecode(frame.body!);
          _handleWebSocketMessage(data);
        }
      },
    );
  }

  void _handleWebSocketMessage(Map<String, dynamic> data) {
    final type = data['type'];
    final driverId = data['driverId'];

    if (type == 'location') {
      final location = data['location'];
      final lat = location['latitude'];
      final lng = location['longitude'];

      setState(() {
        _busMarkers[driverId] = Marker(
          point: LatLng(lat, lng),
          width: 40,
          height: 40,
          child: const Icon(
            Icons.directions_bus,
            color: Colors.amber,
            size: 30,
          ),
        );
      });
    } else if (type == 'end') {
      print('end received');
      setState(() {
        _busMarkers.remove(driverId);
      });
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    if (_unsubscribeFn != null) {
      _unsubscribeFn();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 1000;

    return Stack(
      children: [
        BusMap(
          mapController: _mapController,
          routePoints: _routePoints,
          stopsLocations: _stopsLocations,
          userLocation: _userLocation,
          busMarkers: _busMarkers.values.toList(),
        ),

        if (_isLoading) const Center(child: LoadingIndicator()),

        Positioned(
          top: 16,
          left: 16,
          right: isDesktop ? null : 16,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<BusRouteResponseShortDto>(
                    isExpanded: true,
                    hint: Text(localizations.selectRoute),
                    value: _selectedRoute,
                    items: _routes.map((route) {
                      return DropdownMenuItem(
                        value: route,
                        child: Text(route.name),
                      );
                    }).toList(),
                    onChanged: _onRouteSelected,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

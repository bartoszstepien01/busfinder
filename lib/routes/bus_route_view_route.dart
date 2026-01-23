import 'dart:convert';

import 'package:busfinder/api_service.dart';
import 'package:busfinder/components/bus_route_timeline.dart';
import 'package:busfinder/components/error_dialog.dart';
import 'package:busfinder/components/loading_indicator.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:vector_map_tiles/vector_map_tiles.dart';

class BusRouteViewRoute extends StatefulWidget {
  final BusRouteResponseShortDto route;

  const BusRouteViewRoute({super.key, required this.route});

  @override
  State<BusRouteViewRoute> createState() => _BusRouteViewRouteState();
}

class _BusRouteViewRouteState extends State<BusRouteViewRoute> {
  bool _isLoading = true;
  late BusRouteResponseDto _route;
  late List<BusStopResponseDto> _stops;
  late List<LatLng> _stopsLocations;
  late List<LatLng> _routePoints;
  late List<ScheduleResponseDto> _schedules;
  final MapController _mapController = MapController();
  final DraggableScrollableController sheetController =
      DraggableScrollableController();
  Style? style;

  @override
  void initState() {
    super.initState();
    StyleReader(
      uri: 'https://api.maptiler.com/maps/dataviz-v4-dark/style.json?key={key}',
      apiKey: '',
    ).read().then((style) {
      this.style = style;
      _fetchSchedules();
    });
  }

  Future<void> _fetchSchedules() async {
    final api = context.read<ApiService>();
    final schedules = ScheduleControllerApi(api.client);

    try {
      final response = await schedules.getAllSchedules();
      setState(() {
        _schedules = response!.data;
        _fetchRoute();
      });
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  Future<void> _fetchRoute() async {
    final api = context.read<ApiService>();
    final routes = BusRouteControllerApi(api.client);

    try {
      final response = await routes.getRoute(widget.route.id);
      setState(() {
        _route = response!.data!;
        _fetchStops();
      });
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  Future<void> _fetchStops() async {
    final api = context.read<ApiService>();
    final stops = BusStopControllerApi(api.client);

    try {
      final response = await stops.getAllBusStops();

      if (response != null) {
        final locations = _route.variants
            .firstWhere((variant) => variant.standard)
            .busStops
            .map((stopId) {
              final stop = response.data.firstWhere(
                (stop) => stop.id == stopId,
              );
              return LatLng(stop.location.longitude!, stop.location.latitude!);
            })
            .toList();

        _routePoints = await _fetchOsrmRoute(locations);

        setState(() {
          _stops = response.data.toList();
          _stopsLocations = locations;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _buildOsrmUrl(List<LatLng> points) {
    final coords = points.map((p) => '${p.longitude},${p.latitude}').join(';');

    return 'https://router.project-osrm.org/route/v1/driving/$coords'
        '?overview=full&geometries=geojson';
  }

  Future<List<LatLng>> _fetchOsrmRoute(List<LatLng> points) async {
    final url = Uri.parse(_buildOsrmUrl(points));
    final response = await http.get(url);

    final data = jsonDecode(response.body);
    final coordinates = data['routes'][0]['geometry']['coordinates'] as List;

    return coordinates
        .map((c) => LatLng(c[1], c[0])) // lat, lon
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const LoadingIndicator()
          : Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _stopsLocations.first,
                      initialZoom: 5,
                      maxZoom: 18,
                      backgroundColor: theme.colorScheme.surface,
                      initialCameraFit: CameraFit.bounds(
                        bounds: LatLngBounds.fromPoints(_routePoints),
                        padding: const EdgeInsets.all(32),
                      ),
                    ),
                    children: [
                      VectorTileLayer(
                        tileProviders: style!.providers,
                        theme: style!.theme,
                        tileOffset: TileOffset.DEFAULT,
                      ),
                      // TileLayer(
                      // urlTemplate:
                      // 'https://b.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      // userAgentPackageName:
                      // 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36',
                      // ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: _routePoints,
                            strokeWidth: 4,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      MarkerLayer(
                        markers: _stopsLocations
                            .map(
                              (p) => Marker(
                                point: p,
                                width: 15,
                                height: 15,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: theme.colorScheme.surface,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                  DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    minChildSize: 0.12,
                    maxChildSize: 0.7,
                    builder: (context, scrollController) {
                      return Material(
                        color: theme.colorScheme.surface,
                        elevation: 3,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  _route.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              TabBar(
                                tabs: const [
                                  Tab(text: 'Main route'),
                                  Tab(text: 'All variants'),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    BusRouteTimeline(
                                      variants: _route.variants
                                          .where((variant) => variant.standard)
                                          .toList(),
                                      busStops: _stops,
                                      schedules: _schedules,
                                      busRouteId: widget.route.id,
                                    ),
                                    BusRouteTimeline(
                                      variants: _route.variants,
                                      busStops: _stops,
                                      schedules: _schedules,
                                      busRouteId: widget.route.id,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
    );
  }
}

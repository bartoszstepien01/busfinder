import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/widgets/bus_route_timeline.dart';
import 'package:busfinder/widgets/error_dialog.dart';
import 'package:busfinder/widgets/loading_indicator.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:busfinder/services/osrm_service.dart';
import 'package:busfinder/widgets/common/bus_map.dart';

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

  @override
  void initState() {
    super.initState();

    _fetchSchedules();
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

        setState(() {
          _stops = response.data.toList();
          _stopsLocations = locations;
          _routePoints = [];
          _isLoading = false;
        });

        _fetchRoutePoints(locations);
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  Future<void> _fetchRoutePoints(List<LatLng> locations) async {
    final routePoints = await OsrmService.fetchRoute(locations);
    if (mounted) {
      setState(() {
        _routePoints = routePoints;
      });
      if (routePoints.isNotEmpty) {
        _mapController.fitCamera(
          CameraFit.bounds(
            bounds: LatLngBounds.fromPoints(routePoints),
            padding: const EdgeInsets.all(32),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 1000;

    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const LoadingIndicator()
          : Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: BusMap(
                        mapController: _mapController,
                        routePoints: _routePoints,
                        stopsLocations: _stopsLocations,
                        initialCenter: _stopsLocations.isNotEmpty
                            ? _stopsLocations.first
                            : const LatLng(52.2297, 21.0122),
                        initialZoom: 5,
                        initialCameraFit: _routePoints.isNotEmpty
                            ? CameraFit.bounds(
                                bounds: LatLngBounds.fromPoints(_routePoints),
                                padding: const EdgeInsets.all(32),
                              )
                            : null,
                      ),
                    ),
                    if (isDesktop)
                      Expanded(
                        flex: 1,
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  _route.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              TabBar(
                                tabs: [
                                  Tab(text: localizations.mainRoute),
                                  Tab(text: localizations.allVariants),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    BusRouteTimeline(
                                      variants: _route.variants
                                          .where((variant) => variant.standard)
                                          .toList(),
                                      allVariants: _route.variants,
                                      busStops: _stops,
                                      schedules: _schedules,
                                      busRouteId: widget.route.id,
                                    ),
                                    BusRouteTimeline(
                                      variants: _route.variants,
                                      allVariants: _route.variants,
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
                      ),
                  ],
                ),
                if (!isDesktop)
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
                                  color: theme.colorScheme.onSurface,
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
                                tabs: [
                                  Tab(text: localizations.mainRoute),
                                  Tab(text: localizations.allVariants),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    BusRouteTimeline(
                                      variants: _route.variants
                                          .where((variant) => variant.standard)
                                          .toList(),
                                      allVariants: _route.variants,
                                      busStops: _stops,
                                      schedules: _schedules,
                                      busRouteId: widget.route.id,
                                    ),
                                    BusRouteTimeline(
                                      variants: _route.variants,
                                      allVariants: _route.variants,
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

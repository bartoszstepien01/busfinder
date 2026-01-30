import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BusMap extends StatelessWidget {
  const BusMap({
    super.key,
    required this.mapController,
    this.routePoints = const [],
    this.stopsLocations = const [],
    this.userLocation,
    this.busMarkers = const [],
    this.initialCenter = const LatLng(52.2297, 21.0122),
    this.initialZoom = 12,
    this.initialCameraFit,
  });

  final MapController mapController;
  final List<LatLng> routePoints;
  final List<LatLng> stopsLocations;
  final LatLng? userLocation;
  final List<Marker> busMarkers;
  final LatLng initialCenter;
  final double initialZoom;
  final CameraFit? initialCameraFit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    const maptilerKey = String.fromEnvironment('MAPTILER_KEY');

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: initialZoom,
        maxZoom: 18,
        backgroundColor: theme.colorScheme.surface,
        initialCameraFit: initialCameraFit,
      ),
      children: [
        TileLayer(
          urlTemplate: isDark
              ? 'https://api.maptiler.com/maps/dataviz-v4-dark/{z}/{x}/{y}.png?key=$maptilerKey'
              : 'https://api.maptiler.com/maps/dataviz-v4/{z}/{x}/{y}.png?key=$maptilerKey',
        ),
        if (routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: routePoints,
                strokeWidth: 4,
                color: theme.colorScheme.onSurface,
              ),
            ],
          ),
        if (stopsLocations.isNotEmpty)
          MarkerLayer(
            markers: stopsLocations
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
                          color: theme.colorScheme.onSurface,
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        MarkerLayer(
          markers: [
            if (userLocation != null)
              Marker(
                point: userLocation!,
                width: 20,
                height: 20,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ...busMarkers,
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationSelector extends StatelessWidget {
  final MapController mapController;
  final LatLng? initialPosition;

  const LocationSelector({
    super.key,
    required this.mapController,
    this.initialPosition,
  });

  @override
  Widget build(BuildContext context) {
    const maptilerKey = String.fromEnvironment('MAPTILER_KEY');

    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: initialPosition ?? LatLng(52.22977, 21.01178),
            initialZoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://api.maptiler.com/maps/openstreetmap/{z}/{x}/{y}.jpg?key=$maptilerKey',
            ),
          ],
        ),

        Center(
          child: Transform.translate(
            offset: const Offset(0, -20),
            child: const Icon(Icons.location_pin, size: 40, color: Colors.red),
          ),
        ),
      ],
    );
  }
}

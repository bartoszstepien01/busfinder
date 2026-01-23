import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationSelector extends StatelessWidget {
  final MapController mapController;
  final LatLng? initialPosition;

  const LocationSelector({
    super.key, 
    required this.mapController,
    this.initialPosition
  });

  @override
  Widget build(BuildContext context) {
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
              urlTemplate: 'https://b.tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36',
            ),
          ],
        ),
        
        Center(
          child: Transform.translate(
            offset: const Offset(0, -20),
            child: const Icon(
              Icons.location_pin,
              size: 40,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class OsrmService {
  static String _buildOsrmUrl(List<LatLng> points) {
    final coords = points.map((p) => '${p.longitude},${p.latitude}').join(';');
    return 'https://router.project-osrm.org/route/v1/driving/$coords?overview=full&geometries=geojson';
  }

  static Future<List<LatLng>> fetchRoute(List<LatLng> points) async {
    if (points.isEmpty) return [];
    try {
      final url = Uri.parse(_buildOsrmUrl(points));
      final response = await http.get(url);

      if (response.statusCode != 200) {
        return [];
      }

      final data = jsonDecode(response.body);
      if (data['code'] != 'Ok' ||
          data['routes'] == null ||
          (data['routes'] as List).isEmpty) {
        return [];
      }

      final coordinates = data['routes'][0]['geometry']['coordinates'] as List;
      return coordinates.map((c) => LatLng(c[1], c[0])).toList();
    } catch (e) {
      return [];
    }
  }
}

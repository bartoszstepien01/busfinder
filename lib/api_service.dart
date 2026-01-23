import 'package:busfinder_api/api.dart';

class ApiService {
  final ApiClient client;

  ApiService(this.client);

  void setToken(String? token) {
    client.addDefaultHeader('Authorization', 'Bearer $token');
  }
}

import 'dart:async';

import 'package:busfinder_api/api.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ApiService {
  final ApiClient client;
  StompClient webSocketClient;
  Completer<void> webSocketClientConnected = Completer<void>();

  ApiService(this.client, this.webSocketClient);

  void setToken(String? token) {
    client.addDefaultHeader('Authorization', 'Bearer $token');

    webSocketClient.deactivate();
    webSocketClientConnected = Completer();
    webSocketClient = StompClient(
      config: StompConfig(
        url: webSocketClient.config.url,
        stompConnectHeaders: {'Authorization': 'Bearer $token'},
        onConnect: (frame) {
          if (!webSocketClientConnected.isCompleted) {
            webSocketClientConnected.complete();
          }
        },
        onWebSocketError: (dynamic error) {
          if (!webSocketClientConnected.isCompleted) {
            webSocketClientConnected.completeError(error);
          }
        },
        onStompError: (frame) {
          if (!webSocketClientConnected.isCompleted) {
            webSocketClientConnected.completeError(Exception(frame.body));
          }
        },
        onDisconnect: (frame) {
          if (webSocketClientConnected.isCompleted) {
            webSocketClientConnected = Completer();
          }
        },
      ),
    );
  }
}

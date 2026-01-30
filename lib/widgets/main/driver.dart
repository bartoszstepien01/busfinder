import 'dart:async';
import 'dart:convert';

import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/widgets/error_dialog.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class Driver extends StatefulWidget {
  const Driver({super.key});

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  BusRouteResponseShortDto? _selectedRoute;
  List<BusRouteResponseShortDto> _routes = [];
  bool _isDriving = false;
  Timer? _timer;
  String? _statusMessage;

  @override
  void initState() {
    super.initState();
    _fetchRoutes();
  }

  Future<void> _fetchRoutes() async {
    final api = context.read<ApiService>();
    final routesApi = BusRouteControllerApi(api.client);

    try {
      final response = await routesApi.getAllRoutes();

      if (response != null) {
        setState(() {
          _routes = response.data.toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  Future<void> _startDriving() async {
    final localizations = AppLocalizations.of(context)!;

    if (_selectedRoute == null) return;

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _statusMessage = localizations.locationDisabled;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _statusMessage = localizations.permissionsDenied;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _statusMessage = localizations.permissionsDeniedPermanently;
      });
      return;
    }

    setState(() {
      _isDriving = true;
      _statusMessage = localizations.drivingStarted;
    });

    if (!mounted) return;

    final stompClient = context.read<ApiService>().webSocketClient;
    if (!stompClient.connected) {
      stompClient.activate();
    }

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await _sendLocationUpdate();
    });

    await _sendLocationUpdate();
  }

  Future<void> _sendLocationUpdate() async {
    final localizations = AppLocalizations.of(context)!;

    try {
      final position = await Geolocator.getCurrentPosition();
      if (!mounted) return;
      final stompClient = context.read<ApiService>().webSocketClient;

      if (!stompClient.connected) {
        return;
      }

      final message = {
        "type": "location",
        "routeId": _selectedRoute!.id,
        "location": {
          "latitude": position.latitude,
          "longitude": position.longitude,
        },
      };

      stompClient.send(destination: '/driver/send', body: jsonEncode(message));

      if (mounted) {
        setState(() {
          _statusMessage = localizations.locationSent(DateTime.now());
        });
      }
    } catch (e) {
      // no-op
    }
  }

  Future<void> _stopDriving() async {
    final localizations = AppLocalizations.of(context)!;

    _timer?.cancel();

    final stompClient = context.read<ApiService>().webSocketClient;
    if (stompClient.connected) {
      stompClient.send(
        destination: '/driver/send',
        body: jsonEncode({"type": "end"}),
      );
      stompClient.deactivate();
    }

    if (mounted) {
      setState(() {
        _isDriving = false;
        _statusMessage = localizations.drivingStopped;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    if (_isDriving) {
      final stompClient = context.read<ApiService>().webSocketClient;
      if (stompClient.connected) {
        stompClient.send(
          destination: '/driver/send',
          body: jsonEncode({"type": "end"}),
        );
        stompClient.deactivate();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 1000;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 600 : double.infinity,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<BusRouteResponseShortDto>(
                decoration: InputDecoration(
                  labelText: localizations.selectRoute,
                  border: OutlineInputBorder(),
                ),
                initialValue: _selectedRoute,
                items: _routes.map((route) {
                  return DropdownMenuItem(
                    value: route,
                    child: Text(route.name),
                  );
                }).toList(),
                onChanged: _isDriving
                    ? null
                    : (value) {
                        setState(() {
                          _selectedRoute = value;
                        });
                      },
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isDriving ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  onPressed: _selectedRoute == null
                      ? null
                      : (_isDriving ? _stopDriving : _startDriving),
                  child: Text(
                    _isDriving
                        ? localizations.stopDriving
                        : localizations.startDriving,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_statusMessage != null)
                Text(
                  _statusMessage!,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

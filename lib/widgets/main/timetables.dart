import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/widgets/bus_route_entry.dart';
import 'package:busfinder/widgets/error_dialog.dart';
import 'package:busfinder/widgets/loading_indicator.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Timetables extends StatefulWidget {
  const Timetables({super.key});

  @override
  State<Timetables> createState() => _TimetablesState();
}

class _TimetablesState extends State<Timetables> {
  bool _isLoading = true;
  late List<BusRouteResponseShortDto> _routes;

  @override
  void initState() {
    _fetchRoutes();
    super.initState();
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingIndicator()
        : ListView.separated(
            itemBuilder: (context, index) => BusRouteEntry(
              route: _routes[index],
              onTap: () =>
                  context.push('/bus-route', extra: {'route': _routes[index]}),
            ),
            itemCount: _routes.length,
            separatorBuilder: (context, index) => SizedBox(height: 5),
          );
  }
}

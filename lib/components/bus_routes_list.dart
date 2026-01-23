import 'package:busfinder/api_service.dart';
import 'package:busfinder/components/bus_route_entry.dart';
import 'package:busfinder/components/error_dialog.dart';
import 'package:busfinder/components/loading_indicator.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BusRoutesList extends StatefulWidget {
  const BusRoutesList({super.key});

  @override
  State<BusRoutesList> createState() => _BusRoutesListState();
}

class _BusRoutesListState extends State<BusRoutesList> {
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

import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/widgets/bus/bus_route_entry.dart';
import 'package:busfinder/widgets/dialogs/error_dialog.dart';
import 'package:busfinder/widgets/common/loading_indicator.dart';
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
  List<BusRouteResponseShortDto> _routes = [];
  List<BusRouteResponseShortDto> _filteredRoutes = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _fetchRoutes();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchRoutes() async {
    final api = context.read<ApiService>();
    final routesApi = BusRouteControllerApi(api.client);

    try {
      final response = await routesApi.getAllRoutes();

      if (response != null) {
        setState(() {
          _routes = response.data.toList();
          _filteredRoutes = _routes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  void _filterRoutes(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredRoutes = _routes;
      } else {
        _filteredRoutes = _routes
            .where(
              (route) => route.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const LoadingIndicator()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search routes...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceContainer,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    onChanged: _filterRoutes,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) => BusRouteEntry(
                    route: _filteredRoutes[index],
                    onTap: () => context.push(
                      '/bus-route',
                      extra: {'route': _filteredRoutes[index]},
                    ),
                  ),
                  itemCount: _filteredRoutes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                ),
              ),
            ],
          );
  }
}

import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:busfinder/widgets/dialogs/error_dialog.dart';
import 'package:busfinder/widgets/common/loading_indicator.dart';
import 'package:busfinder/widgets/layout/responsive_container.dart';

import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BusRoutesRoute extends StatefulWidget {
  const BusRoutesRoute({super.key});

  @override
  State<BusRoutesRoute> createState() => _BusRoutesRouteState();
}

class _BusRoutesRouteState extends State<BusRoutesRoute> {
  List<BusRouteResponseShortDto> _routes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchRoutes();
  }

  Future<void> fetchRoutes() async {
    final api = context.read<ApiService>();
    final routes = BusRouteControllerApi(api.client);

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await routes.getAllRoutes();

      if (response != null) {
        setState(() {
          _routes = response.data.toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.busRoutes)),
      body: _isLoading
          ? const LoadingIndicator()
          : ResponsiveContainer(
              child: ListView.builder(
                itemCount: _routes.length,
                itemBuilder: (context, index) {
                  final route = _routes[index];
                  return ListTile(
                    leading: const Icon(Icons.directions_bus),
                    title: Text(route.name),
                    onTap: () async {
                      final updatedRoute = await context
                          .push<BusRouteResponseShortDto>(
                            '/admin/routes/edit',
                            extra: {
                              'route': BusRouteResponseShortDto(
                                id: route.id,
                                name: route.name,
                              ),
                            },
                          );
                      if (updatedRoute != null) {
                        setState(() {
                          final index = _routes.indexWhere(
                            (r) => r.id == updatedRoute.id,
                          );
                          if (index != -1) {
                            _routes[index] = updatedRoute;
                          }
                        });
                      }
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmDeleteDialog(
                            content: localizations.areYouSureDeleteRoute(
                              route.name,
                            ),
                            onConfirm: () async {
                              final api = context.read<ApiService>();
                              final routes = BusRouteControllerApi(api.client);

                              try {
                                await routes.deleteRoute(
                                  DeleteBusRouteDto(id: route.id),
                                );
                                if (context.mounted) {
                                  setState(() {
                                    _routes.removeWhere(
                                      (r) => r.id == route.id,
                                    );
                                  });
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ErrorDialog.show(context, e);
                                }
                              }
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRoute = await context.push<BusRouteResponseDto>(
            '/admin/routes/add',
          );
          if (newRoute != null) {
            setState(() {
              _routes.add(
                BusRouteResponseShortDto(id: newRoute.id, name: newRoute.name),
              );
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

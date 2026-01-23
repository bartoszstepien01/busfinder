import 'package:busfinder/api_service.dart';
import 'package:busfinder/components/confirm_delete_dialog.dart';
import 'package:busfinder/components/error_dialog.dart';
import 'package:busfinder/components/loading_indicator.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StopsRoute extends StatefulWidget {
  const StopsRoute({super.key});

  @override
  State<StopsRoute> createState() => _StopsRouteState();
}

class _StopsRouteState extends State<StopsRoute> {
  List<BusStopResponseDto> _stops = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchAllStops();
  }

  Future<void> fetchAllStops() async {
    final api = context.read<ApiService>();
    final stops = BusStopControllerApi(api.client);

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await stops.getAllBusStops();

      if (response != null) {
        setState(() {
          _stops = response.data.toList();
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
      appBar: AppBar(title: Text(localizations.stops)),
      body: _isLoading
          ? const LoadingIndicator()
          : ListView.builder(
              itemCount: _stops.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.location_pin),
                title: Text(_stops[index].name),
                trailing: InkWell(
                  child: Icon(Icons.delete),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => ConfirmDeleteDialog(
                      content: localizations
                          .areYouSureDeleteStop(_stops[index].name),
                      onConfirm: () async {
                        final api = context.read<ApiService>();
                        final stops = BusStopControllerApi(api.client);
                        final payload = DeleteBusStopDto(id: _stops[index].id);

                        try {
                          await stops.deleteBusStop(payload);
                          if (context.mounted) {
                            setState(() {
                              _stops.removeAt(index);
                            });
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ErrorDialog.show(context, e);
                          }
                        }
                      },
                    ),
                  ),
                ),
                onTap: () async {
                  final updatedStop = await context.push<BusStopResponseDto>(
                    '/admin/stops/edit',
                    extra: {
                      'busStop': BusStopResponseDto(
                        id: _stops[index].id,
                        name: _stops[index].name,
                        location: LocationDto(
                          longitude: _stops[index].location.longitude,
                          latitude: _stops[index].location.latitude,
                        ),
                      ),
                    },
                  );
                  if (updatedStop != null) {
                    setState(() {
                      _stops[index] = updatedStop;
                    });
                  }
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newStop = await context.push<BusStopResponseDto>('/admin/stops/add');
          if (newStop != null) {
            setState(() {
              _stops.add(newStop);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

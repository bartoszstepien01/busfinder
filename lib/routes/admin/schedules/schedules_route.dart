import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/widgets/confirm_delete_dialog.dart';
import 'package:busfinder/widgets/error_dialog.dart';
import 'package:busfinder/widgets/loading_indicator.dart';
import 'package:busfinder/widgets/responsive_container.dart';
import 'package:busfinder/routes/admin/schedules/widgets/schedules_filter.dart';
import 'package:busfinder/routes/admin/schedules/widgets/schedule_list_item.dart';

import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SchedulesRoute extends StatefulWidget {
  const SchedulesRoute({super.key});

  @override
  State<SchedulesRoute> createState() => _SchedulesRouteState();
}

class _SchedulesRouteState extends State<SchedulesRoute> {
  List<BusRouteResponseShortDto> _routes = [];
  List<ScheduleResponseDto> _schedules = [];
  bool _isLoading = true;

  // Filters
  String? _selectedRouteId;
  String? _selectedDayType;

  @override
  void initState() {
    super.initState();
    _fetchRoutes();
  }

  Future<void> _fetchRoutes() async {
    final api = context.read<ApiService>();
    final routesApi = BusRouteControllerApi(api.client);

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await routesApi.getAllRoutes();

      if (response != null) {
        setState(() {
          _routes = response.data.toList();
          _fetchSchedules();
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  Future<void> _fetchSchedules() async {
    final api = context.read<ApiService>();
    final schedule = ScheduleControllerApi(api.client);

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await schedule.getAllSchedules();

      if (response != null) {
        setState(() {
          _schedules = response.data.toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  List<ScheduleResponseDto> get _filteredSchedules {
    return _schedules.where((schedule) {
      if (_selectedRouteId != null && schedule.routeId != _selectedRouteId) {
        return false;
      }
      if (_selectedDayType != null &&
          schedule.dayType.value != _selectedDayType) {
        return false;
      }
      return true;
    }).toList();
  }

  String _getDayTypeLabel(String dayType) {
    final localizations = AppLocalizations.of(context)!;

    switch (dayType) {
      case 'workday':
        return localizations.workday;
      case 'saturday':
        return localizations.saturday;
      case 'sunday':
        return localizations.sunday;
      case 'holiday':
        return localizations.holiday;
      case 'special':
        return localizations.special;
      default:
        return dayType;
    }
  }

  void _deleteSchedule(ScheduleResponseDto schedule) {
    final localizations = AppLocalizations.of(context)!;
    final route = _routes
        .where((element) => element.id == schedule.routeId)
        .firstOrNull;

    showDialog(
      context: context,
      builder: (context) => ConfirmDeleteDialog(
        content: localizations.areYouSureDeleteSchedule(
          '${route?.name} (${_getDayTypeLabel(schedule.dayType.value)}',
        ),
        onConfirm: () async {
          final api = context.read<ApiService>();
          final schedulesApi = ScheduleControllerApi(api.client);

          try {
            await schedulesApi.deleteSchedule(
              DeleteScheduleDto(id: schedule.id),
            );

            if (mounted) {
              setState(() {
                _schedules.removeWhere((s) => s.id == schedule.id);
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
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.schedules)),
      body: _isLoading
          ? const LoadingIndicator()
          : ResponsiveContainer(
              child: Column(
                children: [
                  SchedulesFilter(
                    routes: _routes,
                    selectedRouteId: _selectedRouteId,
                    selectedDayType: _selectedDayType,
                    onRouteChanged: (value) {
                      setState(() {
                        _selectedRouteId = value;
                      });
                    },
                    onDayTypeChanged: (value) {
                      setState(() {
                        _selectedDayType = value;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: _filteredSchedules.isEmpty
                        ? Center(
                            child: Text(
                              localizations.noSchedules,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                        : ListView.builder(
                            itemCount: _filteredSchedules.length,
                            itemBuilder: (context, index) {
                              final schedule = _filteredSchedules[index];
                              final route = _routes
                                  .where(
                                    (element) => element.id == schedule.routeId,
                                  )
                                  .firstOrNull;
                              return ScheduleListItem(
                                schedule: schedule,
                                routeName: route?.name ?? '',
                                onEdit: () async {
                                  final result = await context
                                      .push<ScheduleResponseDto>(
                                        '/admin/schedules/edit',
                                        extra: {'schedule': schedule},
                                      );
                                  if (result != null) {
                                    setState(() {
                                      final idx = _schedules.indexWhere(
                                        (s) => s.id == result.id,
                                      );
                                      if (idx != -1) {
                                        _schedules[idx] = result;
                                      }
                                    });
                                  }
                                },
                                onDelete: () => _deleteSchedule(schedule),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push<ScheduleResponseDto>(
            '/admin/schedules/add',
            extra: {'routes': _routes},
          );
          if (result != null) {
            setState(() {
              _schedules.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

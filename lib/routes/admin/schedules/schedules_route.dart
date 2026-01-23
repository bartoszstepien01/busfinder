import 'package:busfinder/api_service.dart';
import 'package:busfinder/components/confirm_delete_dialog.dart';
import 'package:busfinder/components/error_dialog.dart';
import 'package:busfinder/components/loading_indicator.dart';

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

  static const List<String> dayTypes = [
    'workday',
    'saturday',
    'sunday',
    'holiday',
    'special',
  ];

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
      if (_selectedDayType != null && schedule.dayType.value != _selectedDayType) {
        return false;
      }
      return true;
    }).toList();
  }

  String _getDayTypeLabel(String dayType) {
    switch (dayType) {
      case 'workday':
        return 'Workday';
      case 'saturday':
        return 'Saturday';
      case 'sunday':
        return 'Sunday';
      case 'holiday':
        return 'Holiday';
      case 'special':
        return 'Special';
      default:
        return dayType;
    }
  }

  void _deleteSchedule(ScheduleResponseDto schedule) {
    final route = _routes.where((element) => element.id == schedule.routeId).firstOrNull;

    showDialog(
      context: context,
      builder: (context) => ConfirmDeleteDialog(
        content:
            'Are you sure you want to delete the ${route?.name} (${_getDayTypeLabel(schedule.dayType.value)}) schedule?',
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
            if (mounted) {
              ErrorDialog.show(context, e);
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedules')),
      body: _isLoading
          ? const LoadingIndicator()
          : Column(
              children: [
                // Filters
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String?>(
                          initialValue: _selectedRouteId,
                          decoration: const InputDecoration(
                            labelText: 'Bus Route',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          items: [
                            const DropdownMenuItem<String?>(
                              value: null,
                              child: Text('All routes'),
                            ),
                            ..._routes.map(
                              (route) => DropdownMenuItem<String?>(
                                value: route.id,
                                child: Text(route.name),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedRouteId = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String?>(
                          initialValue: _selectedDayType,
                          decoration: const InputDecoration(
                            labelText: 'Day Type',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          items: [
                            const DropdownMenuItem<String?>(
                              value: null,
                              child: Text('All types'),
                            ),
                            ...dayTypes.map(
                              (type) => DropdownMenuItem<String?>(
                                value: type,
                                child: Text(_getDayTypeLabel(type)),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedDayType = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                // Schedule list
                Expanded(
                  child: _filteredSchedules.isEmpty
                      ? Center(
                          child: Text(
                            'No schedules found',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      : ListView.builder(
                          itemCount: _filteredSchedules.length,
                          itemBuilder: (context, index) {
                            final schedule = _filteredSchedules[index];
                            final route = _routes.where((element) => element.id == schedule.routeId).firstOrNull;
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.schedule),
                                title: Text(route?.name ?? 'Unknown'),
                                subtitle: Text(
                                  '${_getDayTypeLabel(schedule.dayType.value)} • ${schedule.timetable.length} stops',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () async {
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
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => _deleteSchedule(schedule),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
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

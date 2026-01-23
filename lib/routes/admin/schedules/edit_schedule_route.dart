import 'package:busfinder/api_service.dart';
import 'package:busfinder/components/error_dialog.dart';
import 'package:busfinder/components/loading_indicator.dart';
import 'package:busfinder/models/course.dart';

import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditScheduleRoute extends StatefulWidget {
  const EditScheduleRoute({super.key, required this.schedule});

  final ScheduleResponseDto schedule;

  @override
  State<EditScheduleRoute> createState() => _EditScheduleRouteState();
}

class _EditScheduleRouteState extends State<EditScheduleRoute> {
  BusRouteResponseDto? _routeDetails;
  List<BusStopResponseDto> _allBusStops = [];
  List<Course> _courses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final api = context.read<ApiService>();
    final routesApi = BusRouteControllerApi(api.client);
    final stopsApi = BusStopControllerApi(api.client);

    try {
      final routeResponse = await routesApi.getRoute(widget.schedule.routeId);
      final stopsResponse = await stopsApi.getAllBusStops();

      if (routeResponse != null && stopsResponse != null) {
        setState(() {
          _routeDetails = routeResponse.data;
          _allBusStops = stopsResponse.data.toList();
          _courses = _parseCourses(widget.schedule.timetable);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<Course> _parseCourses(Map<String, List<BusArrivalDto>> timetable) {
    if (timetable.isEmpty) return [];

    // Group arrivals by course number
    final Map<int, Map<String, String>> courseStops = {};
    final Map<int, String> courseVariants = {};

    timetable.forEach((stopId, arrivals) {
      for (var arrival in arrivals) {
        if (!courseStops.containsKey(arrival.courseNumber)) {
          courseStops[arrival.courseNumber] = {};
          courseVariants[arrival.courseNumber] = arrival.routeVariantId;
        }
        courseStops[arrival.courseNumber]![stopId] = arrival.time;
      }
    });

    final List<Course> courses = [];
    courseStops.forEach((courseNumber, stopTimes) {
      final variantId = courseVariants[courseNumber]!;
      final variant = _routeDetails?.variants.firstWhere(
        (v) => v.id == variantId,
        orElse: () => RouteVariantResponseDto(
          id: variantId,
          name: 'Unknown',
          standard: false,
          busStops: [],
        ),
      );

      courses.add(Course(
        courseNumber: courseNumber,
        variantId: variantId,
        variantName: variant?.standard == true ? 'Standard' : (variant?.name ?? 'Unknown'),
        stopTimes: stopTimes,
      ));
    });

    courses.sort((a, b) => a.courseNumber.compareTo(b.courseNumber));
    return courses;
  }

  Future<void> _saveSchedule() async {
    final api = context.read<ApiService>();
    final schedulesApi = ScheduleControllerApi(api.client);

    // Convert courses back to timetable format
    final Map<String, List<BusArrivalDto>> timetable = {};
    
    for (var course in _courses) {
      course.stopTimes.forEach((stopId, time) {
        if (!timetable.containsKey(stopId)) {
          timetable[stopId] = [];
        }
        timetable[stopId]!.add(BusArrivalDto(
          time: time,
          courseNumber: course.courseNumber,
          routeVariantId: course.variantId,
        ));
      });
    }

    try {
      final response = await schedulesApi.editSchedule(
        EditScheduleDto(
          id: widget.schedule.id,
          timetable: timetable,
        ),
      );

      if (mounted && response?.data != null) {
        context.pop(response!.data);
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  void _addCourse() async {
    if (_routeDetails == null || _routeDetails!.variants.isEmpty) {
      return;
    }

    final result = await showDialog<Course>(
      context: context,
      builder: (context) => _AddCourseDialog(
        variants: _routeDetails!.variants,
        allBusStops: _allBusStops,
        nextCourseNumber: _courses.isEmpty
            ? 1
            : _courses.map((c) => c.courseNumber).reduce((a, b) => a > b ? a : b) + 1,
      ),
    );

    if (result != null) {
      setState(() {
        _courses.add(result);
      });
    }
  }

  void _editCourse(int index) async {
    if (_routeDetails == null) {
      return;
    }

    final course = _courses[index];
    final result = await showDialog<Course>(
      context: context,
      builder: (context) => _AddCourseDialog(
        variants: _routeDetails!.variants,
        allBusStops: _allBusStops,
        nextCourseNumber: course.courseNumber,
        existingCourse: course,
      ),
    );

    if (result != null) {
      setState(() {
        _courses[index] = result;
      });
    }
  }

  void _deleteCourse(int index) {
    setState(() {
      _courses.removeAt(index);
    });
  }

  String _getStopName(String stopId) {
    final stop = _allBusStops.firstWhere(
      (s) => s.id == stopId,
      orElse: () => BusStopResponseDto(
        id: stopId,
        name: 'Unknown Stop',
        location: LocationDto(latitude: 0, longitude: 0),
      ),
    );
    return stop.name;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Schedule')),
        body: const LoadingIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSchedule,
          ),
        ],
      ),
      body: _courses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.schedule, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No courses yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text('Tap the + button to add a course'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                final course = _courses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('Course ${index + 1}'),
                    subtitle: Text('Variant: ${course.variantName}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () => _editCourse(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20),
                          onPressed: () => _deleteCourse(index),
                        ),
                      ],
                    ),
                    children: () {
                      final variant = _routeDetails?.variants.firstWhere(
                        (v) => v.id == course.variantId,
                        orElse: () => RouteVariantResponseDto(
                          id: course.variantId,
                          name: 'Unknown',
                          standard: false,
                          busStops: [],
                        ),
                      );

                      final stopIds = variant?.busStops.isNotEmpty == true
                          ? variant!.busStops
                          : course.stopTimes.keys.toList();

                      return stopIds
                          .where((stopId) => course.stopTimes.containsKey(stopId))
                          .map((stopId) {
                        final time = course.stopTimes[stopId]!;
                        return ListTile(
                          contentPadding: const EdgeInsets.only(
                            left: 72,
                            right: 16,
                          ),
                          leading: const Icon(Icons.location_pin),
                          title: Text(_getStopName(stopId)),
                          trailing: Text(
                            time,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      }).toList();
                    }(),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCourse,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Dialog for adding/editing a course
class _AddCourseDialog extends StatefulWidget {
  const _AddCourseDialog({
    required this.variants,
    required this.allBusStops,
    required this.nextCourseNumber,
    this.existingCourse,
  });

  final List<RouteVariantResponseDto> variants;
  final List<BusStopResponseDto> allBusStops;
  final int nextCourseNumber;
  final Course? existingCourse;

  @override
  State<_AddCourseDialog> createState() => _AddCourseDialogState();
}

class _AddCourseDialogState extends State<_AddCourseDialog> {
  RouteVariantResponseDto? _selectedVariant;
  late Map<String, String> _stopTimes;
  late int _courseNumber;

  @override
  void initState() {
    super.initState();
    _courseNumber = widget.nextCourseNumber;
    _stopTimes = {};

    if (widget.existingCourse != null) {
      _selectedVariant = widget.variants.firstWhere(
        (v) => v.id == widget.existingCourse!.variantId,
        orElse: () => widget.variants.first,
      );
      _stopTimes = Map.from(widget.existingCourse!.stopTimes);
    }
  }

  void _onVariantChanged(RouteVariantResponseDto? variant) {
    setState(() {
      _selectedVariant = variant;
      if (variant != null && widget.existingCourse == null) {
        // Initialize empty times for each stop
        _stopTimes = {for (var stopId in variant.busStops) stopId: ''};
      }
    });
  }

  void _pickTime(String stopId) async {
    final currentTime = _stopTimes[stopId];
    TimeOfDay initialTime = TimeOfDay.now();

    if (currentTime != null && currentTime.isNotEmpty) {
      final parts = currentTime.split(':');
      if (parts.length >= 2) {
        initialTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 0,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      }
    }

    final time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (time != null) {
      setState(() {
        _stopTimes[stopId] =
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  String _getStopName(String stopId) {
    final stop = widget.allBusStops.firstWhere(
      (s) => s.id == stopId,
      orElse: () => BusStopResponseDto(
        id: stopId,
        name: 'Unknown Stop',
        location: LocationDto(latitude: 0, longitude: 0),
      ),
    );
    return stop.name;
  }

  bool _isValid() {
    if (_selectedVariant == null) return false;
    return _stopTimes.values.every((time) => time.isNotEmpty);
  }

  void _save() {
    if (!_isValid()) return;

    final course = Course(
      courseNumber: _courseNumber,
      variantId: _selectedVariant!.id,
      variantName:
          _selectedVariant!.standard ? 'Standard' : _selectedVariant!.name,
      stopTimes: Map.from(_stopTimes),
    );

    Navigator.pop(context, course);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingCourse == null ? 'Add Course' : 'Edit Course'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<RouteVariantResponseDto>(
              // Using value is correct for DropdownButtonFormField
              value: _selectedVariant,
              decoration: const InputDecoration(
                labelText: 'Variant',
                border: OutlineInputBorder(),
              ),
              items: widget.variants
                  .map(
                    (variant) => DropdownMenuItem<RouteVariantResponseDto>(
                      value: variant,
                      child: Text(variant.standard ? 'Standard' : variant.name),
                    ),
                  )
                  .toList(),
              onChanged: _onVariantChanged,
            ),
            if (_selectedVariant != null) ...[
              const SizedBox(height: 16),
              Text(
                'Stop Times',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: _selectedVariant!.busStops.map((stopId) {
                      final time = _stopTimes[stopId] ?? '';
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.location_pin),
                        title: Text(_getStopName(stopId)),
                        trailing: OutlinedButton(
                          onPressed: () => _pickTime(stopId),
                          child: Text(
                            time.isEmpty ? 'Set time' : time,
                            style: TextStyle(
                              color: time.isEmpty ? Colors.grey : null,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isValid() ? _save : null,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

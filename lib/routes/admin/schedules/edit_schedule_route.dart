import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/widgets/error_dialog.dart';
import 'package:busfinder/widgets/loading_indicator.dart';
import 'package:busfinder/models/course.dart';
import 'package:busfinder/widgets/responsive_container.dart';
import 'package:busfinder/routes/admin/schedules/widgets/course_dialog.dart';
import 'package:busfinder/routes/admin/schedules/widgets/course_list_item.dart';

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
  bool _isSaving = false;

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
    final localizations = AppLocalizations.of(context)!;
    if (timetable.isEmpty) return [];

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

      courses.add(
        Course(
          courseNumber: courseNumber,
          variantId: variantId,
          variantName: variant?.standard == true
              ? localizations.standard
              : (variant?.name ?? ''),
          stopTimes: stopTimes,
        ),
      );
    });

    courses.sort((a, b) => a.courseNumber.compareTo(b.courseNumber));
    return courses;
  }

  Future<void> _saveSchedule() async {
    final api = context.read<ApiService>();
    final schedulesApi = ScheduleControllerApi(api.client);

    final Map<String, List<BusArrivalDto>> timetable = {};

    for (var course in _courses) {
      course.stopTimes.forEach((stopId, time) {
        if (!timetable.containsKey(stopId)) {
          timetable[stopId] = [];
        }
        timetable[stopId]!.add(
          BusArrivalDto(
            time: time,
            courseNumber: course.courseNumber,
            routeVariantId: course.variantId,
          ),
        );
      });
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final response = await schedulesApi.editSchedule(
        EditScheduleDto(id: widget.schedule.id, timetable: timetable),
      );

      if (mounted && response?.data != null) {
        context.pop(response!.data);
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _addCourse() async {
    if (_routeDetails == null || _routeDetails!.variants.isEmpty) {
      return;
    }

    final result = await showDialog<Course>(
      context: context,
      builder: (context) => CourseDialog(
        variants: _routeDetails!.variants,
        allBusStops: _allBusStops,
        nextCourseNumber: _courses.isEmpty
            ? 1
            : _courses
                      .map((c) => c.courseNumber)
                      .reduce((a, b) => a > b ? a : b) +
                  1,
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
      builder: (context) => CourseDialog(
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(localizations.editSchedule)),
        body: const LoadingIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.editSchedule),
        actions: [
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            )
          else
            IconButton(icon: const Icon(Icons.save), onPressed: _saveSchedule),
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
                    localizations.noCourses,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(localizations.tapToAddCourse),
                ],
              ),
            )
          : ResponsiveContainer(
              child: ListView.builder(
                itemCount: _courses.length,
                itemBuilder: (context, index) {
                  final course = _courses[index];
                  return CourseListItem(
                    course: course,
                    index: index,
                    routeDetails: _routeDetails,
                    allBusStops: _allBusStops,
                    onEdit: () => _editCourse(index),
                    onDelete: () => _deleteCourse(index),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCourse,
        child: const Icon(Icons.add),
      ),
    );
  }
}

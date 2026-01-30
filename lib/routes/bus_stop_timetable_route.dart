import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/widgets/bus/timetable_list.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';

class BusStopTimetableArguments {
  final List<ScheduleResponseDto> schedules;
  final String busStopId;
  final String busStopName;
  final String busRouteId;
  final List<RouteVariantResponseDto> variants;

  BusStopTimetableArguments({
    required this.schedules,
    required this.busStopId,
    required this.busStopName,
    required this.busRouteId,
    required this.variants,
  });
}

class BusStopTimetableRoute extends StatefulWidget {
  final BusStopTimetableArguments args;

  const BusStopTimetableRoute({super.key, required this.args});

  @override
  State<BusStopTimetableRoute> createState() => _BusStopTimetableRouteState();
}

class _BusStopTimetableRouteState extends State<BusStopTimetableRoute> {
  late Map<ScheduleResponseDtoDayTypeEnum, ScheduleResponseDto>
  _schedulesByDayType;
  late List<ScheduleResponseDtoDayTypeEnum> _availableDayTypes;
  late Map<String, String> _variantLetters;

  @override
  void initState() {
    super.initState();
    _processData();
  }

  void _processData() {
    final routeSchedules = widget.args.schedules
        .where((s) => s.routeId == widget.args.busRouteId)
        .toList();

    _schedulesByDayType = {};
    for (var schedule in routeSchedules) {
      if (!_schedulesByDayType.containsKey(schedule.dayType)) {
        _schedulesByDayType[schedule.dayType] = schedule;
      }
    }

    _availableDayTypes = _schedulesByDayType.keys.toList()
      ..sort((a, b) => _dayTypeOrder(a).compareTo(_dayTypeOrder(b)));

    _variantLetters = {};
    int letterIndex = 0;
    final sortedVariants = List<RouteVariantResponseDto>.from(
      widget.args.variants,
    )..sort((a, b) => a.name.compareTo(b.name));

    for (var variant in sortedVariants) {
      if (!variant.standard) {
        _variantLetters[variant.id] = String.fromCharCode(
          'a'.codeUnitAt(0) + letterIndex,
        );
        letterIndex++;
      }
    }
  }

  int _dayTypeOrder(ScheduleResponseDtoDayTypeEnum type) {
    switch (type) {
      case ScheduleResponseDtoDayTypeEnum.workday:
        return 0;
      case ScheduleResponseDtoDayTypeEnum.saturday:
        return 1;
      case ScheduleResponseDtoDayTypeEnum.sunday:
        return 2;
      case ScheduleResponseDtoDayTypeEnum.holiday:
        return 3;
      case ScheduleResponseDtoDayTypeEnum.special:
        return 4;
      default:
        return 5;
    }
  }

  String _getDayTypeLabel(ScheduleResponseDtoDayTypeEnum type) {
    final localizations = AppLocalizations.of(context)!;

    switch (type) {
      case ScheduleResponseDtoDayTypeEnum.workday:
        return localizations.workday;
      case ScheduleResponseDtoDayTypeEnum.saturday:
        return localizations.saturday;
      case ScheduleResponseDtoDayTypeEnum.sunday:
        return localizations.sunday;
      case ScheduleResponseDtoDayTypeEnum.holiday:
        return localizations.holiday;
      case ScheduleResponseDtoDayTypeEnum.special:
        return localizations.special;
      default:
        return type.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 1000;

    if (_availableDayTypes.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.args.busStopName)),
        body: Center(child: Text(localizations.noSchedulesAvailable)),
      );
    }

    return DefaultTabController(
      length: _availableDayTypes.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.args.busStopName),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: isDesktop ? TabAlignment.center : null,
            tabs: _availableDayTypes
                .map((type) => Tab(text: _getDayTypeLabel(type)))
                .toList(),
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 1000 : double.infinity,
            ),
            child: TabBarView(
              children: _availableDayTypes.map((type) {
                final schedule = _schedulesByDayType[type]!;
                return TimetableList(
                  schedule: schedule,
                  busStopId: widget.args.busStopId,
                  variantLetters: _variantLetters,
                  variants: widget.args.variants,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

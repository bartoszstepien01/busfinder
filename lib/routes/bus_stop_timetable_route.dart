import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';

class BusStopTimetableRoute extends StatefulWidget {
  final List<ScheduleResponseDto> schedules;
  final String busStopId;
  final String busStopName;
  final String busRouteId;
  final List<RouteVariantResponseDto> variants;

  const BusStopTimetableRoute({
    super.key,
    required this.schedules,
    required this.busStopId,
    required this.busStopName,
    required this.busRouteId,
    required this.variants,
  });

  @override
  State<BusStopTimetableRoute> createState() => _BusStopTimetableRouteState();
}

class _BusStopTimetableRouteState extends State<BusStopTimetableRoute> {
  late Map<ScheduleResponseDtoDayTypeEnum, ScheduleResponseDto> _schedulesByDayType;
  late List<ScheduleResponseDtoDayTypeEnum> _availableDayTypes;
  late Map<String, String> _variantLetters;

  @override
  void initState() {
    super.initState();
    _processData();
  }

  void _processData() {
    // 1. Filter schedules for this route
    final routeSchedules = widget.schedules
        .where((s) => s.routeId == widget.busRouteId)
        .toList();

    // 2. Group by DayType (take the first one found for each type as per plan)
    _schedulesByDayType = {};
    for (var schedule in routeSchedules) {
      if (!_schedulesByDayType.containsKey(schedule.dayType)) {
        _schedulesByDayType[schedule.dayType] = schedule;
      }
    }

    // 3. Sort DayTypes
    _availableDayTypes = _schedulesByDayType.keys.toList()
      ..sort((a, b) => _dayTypeOrder(a).compareTo(_dayTypeOrder(b)));

    // 4. Assign letters to non-standard variants
    _variantLetters = {};
    int letterIndex = 0;
    // Sort variants to ensure consistent lettering (e.g. by name)
    final sortedVariants = List<RouteVariantResponseDto>.from(widget.variants)
      ..sort((a, b) => a.name.compareTo(b.name));

    for (var variant in sortedVariants) {
      if (!variant.standard) {
        // Assign a, b, c...
        _variantLetters[variant.id] = String.fromCharCode('a'.codeUnitAt(0) + letterIndex);
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
    switch (type) {
      case ScheduleResponseDtoDayTypeEnum.workday:
        return 'Workday';
      case ScheduleResponseDtoDayTypeEnum.saturday:
        return 'Saturday';
      case ScheduleResponseDtoDayTypeEnum.sunday:
        return 'Sunday';
      case ScheduleResponseDtoDayTypeEnum.holiday:
        return 'Holiday';
      case ScheduleResponseDtoDayTypeEnum.special:
        return 'Special';
      default:
        return type.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_availableDayTypes.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.busStopName)),
        body: const Center(
          child: Text('No schedules available for this stop.'),
        ),
      );
    }

    return DefaultTabController(
      length: _availableDayTypes.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.busStopName),
          bottom: TabBar(
            isScrollable: true,
            tabs: _availableDayTypes
                .map((type) => Tab(text: _getDayTypeLabel(type)))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: _availableDayTypes.map((type) {
            final schedule = _schedulesByDayType[type]!;
            return _TimetableList(
              schedule: schedule,
              busStopId: widget.busStopId,
              variantLetters: _variantLetters,
              variants: widget.variants,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _TimetableList extends StatelessWidget {
  final ScheduleResponseDto schedule;
  final String busStopId;
  final Map<String, String> variantLetters;
  final List<RouteVariantResponseDto> variants;

  const _TimetableList({
    required this.schedule,
    required this.busStopId,
    required this.variantLetters,
    required this.variants,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Get arrivals for this stop
    final arrivals = schedule.timetable[busStopId] ?? [];

    if (arrivals.isEmpty) {
      return const Center(child: Text('No buses at this stop for this schedule.'));
    }

    // 2. Sort by time
    final sortedArrivals = List<BusArrivalDto>.from(arrivals)
      ..sort((a, b) => a.time.compareTo(b.time));

    // 3. Group by hour
    final Map<int, List<BusArrivalDto>> arrivalsByHour = {};
    for (var arrival in sortedArrivals) {
      final parts = arrival.time.split(':');
      if (parts.isNotEmpty) {
        final hour = int.tryParse(parts[0]);
        if (hour != null) {
          if (!arrivalsByHour.containsKey(hour)) {
            arrivalsByHour[hour] = [];
          }
          arrivalsByHour[hour]!.add(arrival);
        }
      }
    }

    final sortedHours = arrivalsByHour.keys.toList()..sort();

    // 4. Identify used variants for legend
    final usedVariantIds = sortedArrivals
        .map((a) => a.routeVariantId)
        .toSet()
        .where((id) => variantLetters.containsKey(id))
        .toSet();

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: sortedHours.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final hour = sortedHours[index];
              final hourArrivals = arrivalsByHour[hour]!;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hour column
                    SizedBox(
                      width: 40,
                      child: Text(
                        hour.toString().padLeft(2, '0'),
                        style: const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Minutes
                    Expanded(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: hourArrivals.map((arrival) {
                          final parts = arrival.time.split(':');
                          final minute = parts.length > 1 ? parts[1] : '00';
                          final letter = variantLetters[arrival.routeVariantId] ?? '';

                          return Text(
                            '$minute$letter',
                            style: const TextStyle(fontSize: 18),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        if (usedVariantIds.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Legend:',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                ...usedVariantIds.map((id) {
                  final letter = variantLetters[id]!;
                  final variantName = variants
                      .firstWhere((v) => v.id == id, orElse: () => RouteVariantResponseDto(id: '', name: 'Unknown', standard: false))
                      .name;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('$letter - $variantName'),
                  );
                }),
              ],
            ),
          ),
      ],
    );
  }
}

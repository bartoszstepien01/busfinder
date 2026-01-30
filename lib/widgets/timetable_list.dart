import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';

class TimetableList extends StatelessWidget {
  final ScheduleResponseDto schedule;
  final String busStopId;
  final Map<String, String> variantLetters;
  final List<RouteVariantResponseDto> variants;

  const TimetableList({
    super.key,
    required this.schedule,
    required this.busStopId,
    required this.variantLetters,
    required this.variants,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final arrivals = schedule.timetable[busStopId] ?? [];

    if (arrivals.isEmpty) {
      return Center(child: Text(localizations.noBusesAtThisStop));
    }

    final sortedArrivals = List<BusArrivalDto>.from(arrivals)
      ..sort((a, b) => a.time.compareTo(b.time));

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        hour.toString().padLeft(2, '0'),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: hourArrivals.map((arrival) {
                          final parts = arrival.time.split(':');
                          final minute = parts.length > 1 ? parts[1] : '00';
                          final letter =
                              variantLetters[arrival.routeVariantId] ?? '';

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
                  '${localizations.legend}:',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                ...usedVariantIds.map((id) {
                  final letter = variantLetters[id]!;
                  final variantName = variants
                      .firstWhere(
                        (v) => v.id == id,
                        orElse: () => RouteVariantResponseDto(
                          id: '',
                          name: '',
                          standard: false,
                        ),
                      )
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

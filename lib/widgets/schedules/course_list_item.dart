import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/models/course.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';

class CourseListItem extends StatelessWidget {
  const CourseListItem({
    super.key,
    required this.course,
    required this.index,
    required this.routeDetails,
    required this.allBusStops,
    required this.onEdit,
    required this.onDelete,
  });

  final Course course;
  final int index;
  final BusRouteResponseDto? routeDetails;
  final List<BusStopResponseDto> allBusStops;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  String _getStopName(String stopId) {
    final stop = allBusStops.firstWhere(
      (s) => s.id == stopId,
      orElse: () => BusStopResponseDto(
        id: stopId,
        name: '',
        location: LocationDto(latitude: 0, longitude: 0),
      ),
    );
    return stop.name;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text('${localizations.course} ${index + 1}'),
        subtitle: Text('${localizations.variant}: ${course.variantName}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20),
              onPressed: onDelete,
            ),
          ],
        ),
        children: () {
          final variant = routeDetails?.variants.firstWhere(
            (v) => v.id == course.variantId,
            orElse: () => RouteVariantResponseDto(
              id: course.variantId,
              name: '',
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
                  contentPadding: const EdgeInsets.only(left: 72, right: 16),
                  leading: const Icon(Icons.location_pin),
                  title: Text(_getStopName(stopId)),
                  trailing: Text(
                    time,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              })
              .toList();
        }(),
      ),
    );
  }
}

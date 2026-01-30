import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';

class ScheduleListItem extends StatelessWidget {
  const ScheduleListItem({
    super.key,
    required this.schedule,
    required this.routeName,
    required this.onEdit,
    required this.onDelete,
  });

  final ScheduleResponseDto schedule;
  final String routeName;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  String _getDayTypeLabel(BuildContext context, String dayType) {
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.schedule),
        title: Text(routeName),
        subtitle: Text(
          '${_getDayTypeLabel(context, schedule.dayType.value)} • ${localizations.nStops(schedule.timetable.length)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}

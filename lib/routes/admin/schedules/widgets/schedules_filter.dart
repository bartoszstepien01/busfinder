import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';

class SchedulesFilter extends StatelessWidget {
  const SchedulesFilter({
    super.key,
    required this.routes,
    required this.selectedRouteId,
    required this.selectedDayType,
    required this.onRouteChanged,
    required this.onDayTypeChanged,
  });

  final List<BusRouteResponseShortDto> routes;
  final String? selectedRouteId;
  final String? selectedDayType;
  final ValueChanged<String?> onRouteChanged;
  final ValueChanged<String?> onDayTypeChanged;

  static const List<String> dayTypes = [
    'workday',
    'saturday',
    'sunday',
    'holiday',
    'special',
  ];

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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String?>(
              initialValue: selectedRouteId,
              decoration: InputDecoration(
                labelText: localizations.busRoute,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(localizations.allRoutes),
                ),
                ...routes.map(
                  (route) => DropdownMenuItem<String?>(
                    value: route.id,
                    child: Text(route.name),
                  ),
                ),
              ],
              onChanged: onRouteChanged,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonFormField<String?>(
              initialValue: selectedDayType,
              decoration: InputDecoration(
                labelText: localizations.dayType,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(localizations.allTypes),
                ),
                ...dayTypes.map(
                  (type) => DropdownMenuItem<String?>(
                    value: type,
                    child: Text(_getDayTypeLabel(context, type)),
                  ),
                ),
              ],
              onChanged: onDayTypeChanged,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/widgets/error_dialog.dart';
import 'package:busfinder/widgets/responsive_container.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddScheduleRoute extends StatefulWidget {
  const AddScheduleRoute({super.key, required this.routes});

  final List<BusRouteResponseShortDto> routes;

  @override
  State<AddScheduleRoute> createState() => _AddScheduleRouteState();
}

class _AddScheduleRouteState extends State<AddScheduleRoute> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  static const List<String> dayTypes = [
    'workday',
    'saturday',
    'sunday',
    'holiday',
    'special',
  ];

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

  Future<void> _saveSchedule() async {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) {
      return;
    }

    final dayType = _formKey.currentState?.fields['dayType']?.value as String?;
    final selectedRoute =
        _formKey.currentState?.fields['route']?.value
            as BusRouteResponseShortDto?;

    if (dayType == null || selectedRoute == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final api = context.read<ApiService>();
    final schedulesApi = ScheduleControllerApi(api.client);

    try {
      final response = await schedulesApi.createSchedule(
        CreateScheduleDto(
          routeId: selectedRoute.id,
          dayType: CreateScheduleDtoDayTypeEnum.fromJson(dayType)!,
          timetable: {},
        ),
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
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.addSchedule)),
      body: ResponsiveContainer(
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.addSchedule,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                FormBuilderDropdown<BusRouteResponseShortDto>(
                  name: 'route',
                  decoration: InputDecoration(
                    labelText: localizations.busRoute,
                    icon: Icon(Icons.directions_bus),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(),
                  items: widget.routes
                      .map(
                        (route) => DropdownMenuItem<BusRouteResponseShortDto>(
                          value: route,
                          child: Text(route.name),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                FormBuilderDropdown<String>(
                  name: 'dayType',
                  decoration: InputDecoration(
                    labelText: localizations.dayType,
                    icon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(),
                  items: dayTypes
                      .map(
                        (type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(_getDayTypeLabel(type)),
                        ),
                      )
                      .toList(),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _saveSchedule,
                    icon: _isLoading
                        ? const SizedBox.shrink()
                        : const Icon(Icons.save),
                    label: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(localizations.save),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

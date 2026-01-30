import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/models/course.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';

class CourseDialog extends StatefulWidget {
  const CourseDialog({
    super.key,
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
  State<CourseDialog> createState() => _CourseDialogState();
}

class _CourseDialogState extends State<CourseDialog> {
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
        name: '',
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

    final localizations = AppLocalizations.of(context)!;

    final course = Course(
      courseNumber: _courseNumber,
      variantId: _selectedVariant!.id,
      variantName: _selectedVariant!.standard
          ? localizations.standard
          : _selectedVariant!.name,
      stopTimes: Map.from(_stopTimes),
    );

    Navigator.pop(context, course);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(
        widget.existingCourse == null
            ? localizations.addCourse
            : localizations.editCourse,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<RouteVariantResponseDto>(
              initialValue: _selectedVariant,
              decoration: InputDecoration(
                labelText: localizations.variant,
                border: const OutlineInputBorder(),
              ),
              items: widget.variants
                  .map(
                    (variant) => DropdownMenuItem<RouteVariantResponseDto>(
                      value: variant,
                      child: Text(
                        variant.standard
                            ? localizations.standard
                            : variant.name,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: _onVariantChanged,
            ),
            if (_selectedVariant != null) ...[
              const SizedBox(height: 16),
              Text(
                localizations.stopTimes,
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
                            time.isEmpty ? localizations.setTime : time,
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
          child: Text(localizations.cancel),
        ),
        ElevatedButton(
          onPressed: _isValid() ? _save : null,
          child: Text(localizations.save),
        ),
      ],
    );
  }
}

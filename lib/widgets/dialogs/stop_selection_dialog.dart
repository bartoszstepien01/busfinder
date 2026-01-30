import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';

class StopSelectionDialog extends StatelessWidget {
  const StopSelectionDialog({
    super.key,
    required this.availableStops,
    required this.onStopSelected,
  });

  final List<BusStopResponseDto> availableStops;
  final ValueChanged<BusStopResponseDto> onStopSelected;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(localizations.addStop),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: availableStops.length,
          itemBuilder: (context, index) {
            final stop = availableStops[index];
            return ListTile(
              title: Text(stop.name),
              onTap: () {
                onStopSelected(stop);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}

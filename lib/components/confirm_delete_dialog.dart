import 'package:busfinder/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({
    super.key,
    required this.content,
    required this.onConfirm,
  });

  final String content;
  final Future<void> Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(localizations.areYouSure),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(localizations.no),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(localizations.yes),
          onPressed: () async {
            await onConfirm();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

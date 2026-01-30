import 'package:busfinder/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatefulWidget {
  const ConfirmDeleteDialog({
    super.key,
    required this.content,
    required this.onConfirm,
  });

  final String content;
  final Future<void> Function() onConfirm;

  @override
  State<ConfirmDeleteDialog> createState() => _ConfirmDeleteDialogState();
}

class _ConfirmDeleteDialogState extends State<ConfirmDeleteDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(localizations.areYouSure),
      content: Text(widget.content),

      actions: [
        TextButton(
          child: Text(localizations.no),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          onPressed: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    await widget.onConfirm();
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
          child: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(localizations.yes),
        ),
      ],
    );
  }
}

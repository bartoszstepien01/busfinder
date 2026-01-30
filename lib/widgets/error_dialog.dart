import 'dart:convert';

import 'package:busfinder/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.error});

  final dynamic error;

  static Future<void> show(BuildContext context, dynamic error) async {
    if (!context.mounted) return;
    return showDialog<void>(
      context: context,
      builder: (context) => ErrorDialog(error: error),
    );
  }

  String _getErrorMessage() {
    if (error is String) {
      return error as String;
    }

    try {
      return jsonDecode(error.message)['error'];
    } catch (e) {
      return error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(localizations.error),
      content: Text(_getErrorMessage()),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(localizations.ok),
        ),
      ],
    );
  }
}

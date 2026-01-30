import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/bloc/authentication_state.dart';
import 'package:busfinder/widgets/error_dialog.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTypeDialog extends StatefulWidget {
  const UserTypeDialog({
    super.key,
    required this.userId,
    required this.userType,
  });

  final String userId;
  final UserType userType;

  @override
  State<UserTypeDialog> createState() => _UserTypeDialogState();
}

class _UserTypeDialogState extends State<UserTypeDialog> {
  late UserType _currentUserType;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _currentUserType = widget.userType;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(localizations.selectUserType),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButton<String>(
            value: _currentUserType.index.toString(),
            items: UserType.values.map((UserType type) {
              return DropdownMenuItem<String>(
                value: type.index.toString(),
                child: Text(type.name),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _currentUserType = UserType.values[int.parse(newValue ?? '0')];
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(localizations.cancel),
        ),
        TextButton(
          onPressed: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  final api = context.read<ApiService>();
                  final user = UserControllerApi(api.client);
                  final payload = ChangeUserTypeDto(
                    id: widget.userId,
                    type:
                        ChangeUserTypeDtoTypeEnum.fromJson(
                          _currentUserType.name,
                        ) ??
                        ChangeUserTypeDtoTypeEnum.user,
                  );

                  try {
                    await user.setUserType(payload);
                  } catch (e) {
                    if (context.mounted) {
                      ErrorDialog.show(context, e);
                    }
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }

                  if (context.mounted) {
                    Navigator.of(context).pop(_currentUserType);
                  }
                },
          child: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(localizations.ok),
        ),
      ],
    );
  }
}

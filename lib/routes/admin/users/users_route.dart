import 'package:busfinder/api_service.dart';
import 'package:busfinder/bloc/authentication_state.dart';
import 'package:busfinder/components/confirm_delete_dialog.dart';
import 'package:busfinder/components/error_dialog.dart';
import 'package:busfinder/components/loading_indicator.dart';
import 'package:busfinder/components/user_type_dialog.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersRoute extends StatefulWidget {
  const UsersRoute({super.key});

  @override
  State<UsersRoute> createState() => _UsersRouteState();
}

class _UsersRouteState extends State<UsersRoute> {
  List<UserResponseDto> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchAllUsers();
  }

  Future<void> fetchAllUsers() async {
    final api = context.read<ApiService>();
    final user = UserControllerApi(api.client);

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await user.getAllUsers();

      if (response != null) {
        setState(() {
          _users = response.data.toList();
        });
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

  Future<void> deleteUser(String userId) async {
    final api = context.read<ApiService>();
    final user = UserControllerApi(api.client);
    final payload = DeleteUserDto(id: userId);

    try {
      await user.deleteUser(payload);
      if (mounted) {
        setState(() {
          _users.removeWhere((u) => u.id == userId);
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.users)),
      body: _isLoading
          ? const LoadingIndicator()
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.person),
                title: Text('${_users[index].name} ${_users[index].surname}'),
                subtitle: Text(_users[index].email),
                trailing: InkWell(
                  child: Icon(Icons.delete),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => ConfirmDeleteDialog(
                      content: localizations.areYouSureDeleteUser(
                        _users[index].email,
                      ),
                      onConfirm: () async {
                        await deleteUser(_users[index].id);
                      },
                    ),
                  ),
                ),
                onTap: () async {
                  final newType = await showDialog(
                    context: context,
                    builder: (context) => UserTypeDialog(
                      userId: _users[index].id,
                      userType: UserType.values.firstWhere(
                        (element) =>
                            element.name == _users[index].userType.value,
                      ),
                    ),
                  ) as UserType?;

                  if (newType == null) {
                    return;
                  }

                  setState(() {
                    _users[index].userType =
                        UserResponseDtoUserTypeEnum.fromJson(newType.name) ??
                        UserResponseDtoUserTypeEnum.user;
                  });
                },
              ),
            ),
    );
  }
}

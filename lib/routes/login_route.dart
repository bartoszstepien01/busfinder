import 'package:busfinder/api_service.dart';
import 'package:busfinder/components/auth_form_wrapper.dart';
import 'package:busfinder/bloc/authentication_cubit.dart';
import 'package:busfinder/bloc/authentication_state.dart';
import 'package:busfinder/components/error_dialog.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatelessWidget {
  LoginRoute({super.key});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Unused
    final localizations = AppLocalizations.of(context)!;

    return AuthFormWrapper(
      title: localizations.login,
      subtitle: localizations.login,
      formKey: _formKey,
      children: [
        FormBuilderTextField(
          name: 'email',
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            labelText: localizations.email,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        ),
        const SizedBox(height: 10),
        FormBuilderTextField(
          name: 'password',
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            labelText: localizations.password,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(8),
            FormBuilderValidators.maxLength(64),
          ]),
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () async {
            if (_formKey.currentState!.saveAndValidate()) {
              final api = context.read<ApiService>();
              final authentication = AuthenticationControllerApi(
                api.client,
              );
              final payload = LoginUserDto(
                email: _formKey.currentState?.fields['email']?.value,
                password:
                    _formKey.currentState?.fields['password']?.value,
              );

              try {
                final response = await authentication.authenticate(payload);
                if ((response == null || response.success == false) &&
                    context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Błąd'),
                      content: Text(
                        response?.error ??
                            'Wystąpił błąd. Sprawdź swoje połączenie z internetem',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (context.mounted) {
                  context.read<AuthenticationCubit>().logIn(
                    response?.data?.token ?? '',
                    UserType.values.byName(
                      response?.data?.userType.value ?? 'user',
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ErrorDialog.show(context, e);
                }
              }
            }
          },
          child: Text(localizations.login),
        ),
      ],
    );
  }
}

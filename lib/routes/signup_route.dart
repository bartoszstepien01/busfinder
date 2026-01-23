import 'package:busfinder/components/auth_form_wrapper.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignupRoute extends StatelessWidget {
  SignupRoute({super.key});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Unused
    final localizations = AppLocalizations.of(context)!;

    return AuthFormWrapper(
      title: localizations.singup,
      subtitle: localizations.singup,
      formKey: _formKey,
      children: [
        FormBuilderTextField(
          name: 'name',
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            labelText: localizations.name,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        const SizedBox(height: 10),
        FormBuilderTextField(
          name: 'email',
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            labelText: localizations.email
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
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              print(_formKey.currentState!.value.entries.toList());
            }
          },
          child: Text(localizations.singup),
        ),
      ],
    );
  }
}

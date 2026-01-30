import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AuthFormWrapper extends StatelessWidget {
  const AuthFormWrapper({
    super.key,
    required this.title,
    required this.subtitle,
    required this.formKey,
    required this.children,
  });

  final String title;
  final String subtitle;
  final GlobalKey<FormBuilderState> formKey;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FormBuilder(
        key: formKey,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'BusFinder',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  ...children,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

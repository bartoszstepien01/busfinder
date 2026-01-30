import 'package:busfinder/bloc/authentication_cubit.dart';
import 'package:busfinder/bloc/authentication_state.dart';
import 'package:busfinder/bloc/settings_cubit.dart';
import 'package:busfinder/bloc/settings_state.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 32,
                child: Icon(Icons.person, size: 40),
              ),
              const SizedBox(width: 20),
              Text(localizations.hello, style: theme.textTheme.headlineMedium),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return ListView(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Text(localizations.general),
                  ),
                  ListTile(
                    leading: const Icon(Icons.sunny),
                    title: Text(localizations.theme),
                    onTap: () => _showThemeDialog(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(localizations.language),
                    onTap: () => _showLanguageDialog(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text(localizations.logout),
                    onTap: () => context.read<AuthenticationCubit>().logOut(),
                  ),
                  if (state is LoggedIn &&
                      state.userType == UserType.admin) ...[
                    const Divider(),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Text(localizations.adminOptions),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(localizations.users),
                      onTap: () => context.push('/admin/users'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_pin),
                      title: Text(localizations.stops),
                      onTap: () => context.push('/admin/stops'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.directions_bus),
                      title: Text(localizations.lines),
                      onTap: () => context.push('/admin/routes'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.schedule),
                      title: Text(localizations.schedules),
                      onTap: () => context.push('/admin/schedules'),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void _showThemeDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(localizations.theme),
              content: RadioGroup<ThemeMode>(
                groupValue: state.themeMode,
                onChanged: (value) {
                  if (value != null) {
                    context.read<SettingsCubit>().updateTheme(value);
                  }
                  Navigator.pop(context);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<ThemeMode>(
                      title: Text(localizations.system),
                      value: ThemeMode.system,
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(localizations.light),
                      value: ThemeMode.light,
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(localizations.dark),
                      value: ThemeMode.dark,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(localizations.language),
              content: RadioGroup<String?>(
                groupValue: state.locale?.languageCode,
                onChanged: (value) {
                  context.read<SettingsCubit>().updateLocale(
                    value == null ? null : Locale(value),
                  );
                  Navigator.pop(context);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<String?>(
                      title: Text(localizations.system),
                      value: null,
                    ),
                    RadioListTile<String?>(
                      title: const Text('English'),
                      value: 'en',
                    ),
                    RadioListTile<String?>(
                      title: const Text('polski'),
                      value: 'pl',
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

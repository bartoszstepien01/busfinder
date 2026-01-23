import 'package:busfinder/bloc/authentication_cubit.dart';
import 'package:busfinder/bloc/authentication_state.dart';
import 'package:busfinder/components/bus_routes_list.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({super.key});

  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
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
                Text(
                  localizations.hello('Bartosz'),
                  style: theme.textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(child: 
                    BusRoutesList()),
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
                      onTap: () => null,
                    ),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(localizations.language),
                      onTap: () => null,
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
                        title: const Text('Schedules'),
                        onTap: () => context.push('/admin/schedules'),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: localizations.timetables,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: localizations.map,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: localizations.profile,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() {
          _selectedIndex = value;
        }),
        selectedItemColor: theme.colorScheme.primary,
      ),
    );
  }
}

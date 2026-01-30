import 'package:busfinder/bloc/authentication_cubit.dart';
import 'package:busfinder/bloc/authentication_state.dart';
import 'package:busfinder/widgets/main/driver.dart';
import 'package:busfinder/widgets/main/map.dart';
import 'package:busfinder/widgets/main/profile.dart';
import 'package:busfinder/widgets/main/timetables.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final isDesktop = MediaQuery.of(context).size.width >= 1000;

    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final tabCount =
            (state is LoggedIn && state.userType == UserType.driver) ? 4 : 3;

        return SafeArea(
          child: Scaffold(
            body: Row(
              children: [
                if (isDesktop)
                  NavigationRail(
                    selectedIndex: _selectedIndex % tabCount,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    labelType: NavigationRailLabelType.all,
                    destinations: <NavigationRailDestination>[
                      NavigationRailDestination(
                        icon: Icon(Icons.schedule),
                        label: Text(localizations.timetables),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.map),
                        label: Text(localizations.map),
                      ),
                      if (state is LoggedIn &&
                          state.userType == UserType.driver)
                        NavigationRailDestination(
                          icon: Icon(Icons.directions_bus),
                          label: Text(localizations.driver),
                        ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person),
                        label: Text(localizations.profile),
                      ),
                    ],
                  ),
                if (isDesktop) const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 320),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) {
                      final fade = CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      );
                      final slide =
                          Tween<Offset>(
                            begin: const Offset(0.12, 0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            ),
                          );

                      return FadeTransition(
                        opacity: fade,
                        child: SlideTransition(position: slide, child: child),
                      );
                    },
                    child: IndexedStack(
                      key: ValueKey(_selectedIndex),
                      index: _selectedIndex % tabCount,
                      children: <Widget>[
                        Timetables(),
                        MapWidget(),
                        if (state is LoggedIn &&
                            state.userType == UserType.driver)
                          Driver(),
                        Profile(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: isDesktop
                ? null
                : BottomNavigationBar(
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.schedule),
                        label: localizations.timetables,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.map),
                        label: localizations.map,
                      ),
                      if (state is LoggedIn &&
                          state.userType == UserType.driver)
                        BottomNavigationBarItem(
                          icon: Icon(Icons.directions_bus),
                          label: localizations.driver,
                        ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: localizations.profile,
                      ),
                    ],
                    currentIndex: _selectedIndex % tabCount,
                    onTap: (i) => setState(() => _selectedIndex = i),
                    selectedItemColor: theme.colorScheme.primary,
                    unselectedItemColor: theme.colorScheme.onSurfaceVariant,
                  ),
          ),
        );
      },
    );
  }
}

import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/bloc/authentication_cubit.dart';
import 'package:busfinder/bloc/authentication_state.dart';
import 'package:busfinder/bloc/go_router_refresh_stream.dart';
import 'package:busfinder/routes/routes.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'l10n/app_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:busfinder/bloc/settings_cubit.dart';
import 'package:busfinder/bloc/settings_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const apiUrl = String.fromEnvironment('API_URL');

  final apiService = ApiService(
    ApiClient(basePath: 'https://$apiUrl'),
    StompClient(config: StompConfig(url: 'wss://$apiUrl/location')),
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          ),
  );

  runApp(
    MultiRepositoryProvider(
      providers: [RepositoryProvider<ApiService>.value(value: apiService)],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthenticationCubit(context.read<ApiService>()),
          ),
          BlocProvider(create: (context) => SettingsCubit()),
        ],
        child: BusFinderApp(),
      ),
    ),
  );
}

class BusFinderApp extends StatelessWidget {
  const BusFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthenticationCubit>();

    final router = GoRouter(
      refreshListenable: GoRouterRefreshStream(authCubit.stream),
      redirect: (context, state) {
        final onboarding = {
          '/welcome',
          '/login',
          '/signup',
        }.contains(state.matchedLocation);

        switch (authCubit.state) {
          case NotLoggedIn():
            if (!onboarding) return '/welcome';
          case LoggedIn():
            if (onboarding) return '/';
        }

        return null;
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => MainRoute()),
        GoRoute(path: '/welcome', builder: (context, state) => WelcomeRoute()),
        GoRoute(path: '/login', builder: (context, state) => LoginRoute()),
        GoRoute(path: '/signup', builder: (context, state) => SignupRoute()),
        GoRoute(
          path: '/bus-route',
          builder: (context, state) => BusRouteViewRoute(
            route: (state.extra as Map<String, dynamic>)['route'],
          ),
        ),
        GoRoute(
          path: '/timetable',
          builder: (context, state) => BusStopTimetableRoute(
            args: state.extra as BusStopTimetableArguments,
          ),
        ),
        GoRoute(
          path: '/admin/users',
          builder: (context, state) => UsersRoute(),
        ),
        GoRoute(
          path: '/admin/stops',
          builder: (context, state) => StopsRoute(),
        ),
        GoRoute(
          path: '/admin/stops/add',
          builder: (context, state) => AddStopRoute(),
        ),
        GoRoute(
          path: '/admin/stops/edit',
          builder: (context, state) => AddStopRoute(
            busStop: (state.extra as Map<String, dynamic>)['busStop'],
          ),
        ),
        GoRoute(
          path: '/admin/routes',
          builder: (context, state) => BusRoutesRoute(),
        ),
        GoRoute(
          path: '/admin/routes/add',
          builder: (context, state) => AddBusRouteRoute(),
        ),
        GoRoute(
          path: '/admin/routes/edit',
          builder: (context, state) => EditBusRouteRoute(
            busRoute: (state.extra as Map<String, dynamic>)['route'],
          ),
        ),
        GoRoute(
          path: '/admin/routes/edit/variant',
          builder: (context, state) => AddVariantRoute(
            variant: (state.extra as Map<String, dynamic>?)?['variant'],
          ),
        ),
        GoRoute(
          path: '/admin/schedules',
          builder: (context, state) => const SchedulesRoute(),
        ),
        GoRoute(
          path: '/admin/schedules/add',
          builder: (context, state) => AddScheduleRoute(
            routes: (state.extra as Map<String, dynamic>)['routes'],
          ),
        ),
        GoRoute(
          path: '/admin/schedules/edit',
          builder: (context, state) => EditScheduleRoute(
            schedule: (state.extra as Map<String, dynamic>)['schedule'],
          ),
        ),
      ],
    );

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: state.themeMode,
          localizationsDelegates: [
            ...AppLocalizations.localizationsDelegates,
            FormBuilderLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
          locale: state.locale,
        );
      },
    );
  }
}

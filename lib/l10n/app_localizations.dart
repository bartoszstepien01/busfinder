import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl'),
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to BusFinder!'**
  String get welcome;

  /// No description provided for @personalTravelAssistant.
  ///
  /// In en, this message translates to:
  /// **'Your personal travel assistant'**
  String get personalTravelAssistant;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @singup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get singup;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get name;

  /// No description provided for @surname.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get surname;

  /// No description provided for @timetables.
  ///
  /// In en, this message translates to:
  /// **'Timetables'**
  String get timetables;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get hello;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @adminOptions.
  ///
  /// In en, this message translates to:
  /// **'Administrator options'**
  String get adminOptions;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @stops.
  ///
  /// In en, this message translates to:
  /// **'Bus stops'**
  String get stops;

  /// No description provided for @lines.
  ///
  /// In en, this message translates to:
  /// **'Bus lines'**
  String get lines;

  /// No description provided for @selectUserType.
  ///
  /// In en, this message translates to:
  /// **'Select user type'**
  String get selectUserType;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @areYouSureDeleteUser.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this user ({user})?'**
  String areYouSureDeleteUser(Object user);

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @areYouSureDeleteStop.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this bus stop ({stop})?'**
  String areYouSureDeleteStop(Object stop);

  /// No description provided for @addStop.
  ///
  /// In en, this message translates to:
  /// **'Add bus stop'**
  String get addStop;

  /// No description provided for @editStop.
  ///
  /// In en, this message translates to:
  /// **'Edit bus stop'**
  String get editStop;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @stopName.
  ///
  /// In en, this message translates to:
  /// **'Bus stop name'**
  String get stopName;

  /// No description provided for @mainRoute.
  ///
  /// In en, this message translates to:
  /// **'Main route'**
  String get mainRoute;

  /// No description provided for @allVariants.
  ///
  /// In en, this message translates to:
  /// **'All variants'**
  String get allVariants;

  /// No description provided for @workday.
  ///
  /// In en, this message translates to:
  /// **'Workday'**
  String get workday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holiday;

  /// No description provided for @special.
  ///
  /// In en, this message translates to:
  /// **'Special'**
  String get special;

  /// No description provided for @noSchedulesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No schedules available for this stop.'**
  String get noSchedulesAvailable;

  /// No description provided for @noBusesAtThisStop.
  ///
  /// In en, this message translates to:
  /// **'No buses at this stop for this schedule.'**
  String get noBusesAtThisStop;

  /// No description provided for @legend.
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get legend;

  /// No description provided for @selectRoute.
  ///
  /// In en, this message translates to:
  /// **'Select route'**
  String get selectRoute;

  /// No description provided for @locationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled.'**
  String get locationDisabled;

  /// No description provided for @permissionsDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permissions are denied.'**
  String get permissionsDenied;

  /// No description provided for @permissionsDeniedPermanently.
  ///
  /// In en, this message translates to:
  /// **'Location permissions are permanently denied.'**
  String get permissionsDeniedPermanently;

  /// No description provided for @drivingStarted.
  ///
  /// In en, this message translates to:
  /// **'Driving started.'**
  String get drivingStarted;

  /// No description provided for @locationSent.
  ///
  /// In en, this message translates to:
  /// **'Location sent at {datetime}'**
  String locationSent(Object datetime);

  /// No description provided for @drivingStopped.
  ///
  /// In en, this message translates to:
  /// **'Driving stopped.'**
  String get drivingStopped;

  /// No description provided for @stopDriving.
  ///
  /// In en, this message translates to:
  /// **'Stop driving'**
  String get stopDriving;

  /// No description provided for @startDriving.
  ///
  /// In en, this message translates to:
  /// **'Start driving'**
  String get startDriving;

  /// No description provided for @driver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @routeName.
  ///
  /// In en, this message translates to:
  /// **'Bus route name'**
  String get routeName;

  /// No description provided for @addVariant.
  ///
  /// In en, this message translates to:
  /// **'Add variant'**
  String get addVariant;

  /// No description provided for @editVariant.
  ///
  /// In en, this message translates to:
  /// **'Edit variant'**
  String get editVariant;

  /// No description provided for @variantName.
  ///
  /// In en, this message translates to:
  /// **'Variant name'**
  String get variantName;

  /// No description provided for @busRoutes.
  ///
  /// In en, this message translates to:
  /// **'Bus routes'**
  String get busRoutes;

  /// No description provided for @areYouSureDeleteRoute.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this route ({route})?'**
  String areYouSureDeleteRoute(Object route);

  /// No description provided for @editRoute.
  ///
  /// In en, this message translates to:
  /// **'Edit route'**
  String get editRoute;

  /// No description provided for @nStops.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No stops} =1{1 stop} other{{count} stops}}'**
  String nStops(num count);

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standard;

  /// No description provided for @addSchedule.
  ///
  /// In en, this message translates to:
  /// **'Add schedule'**
  String get addSchedule;

  /// No description provided for @dayType.
  ///
  /// In en, this message translates to:
  /// **'Day type'**
  String get dayType;

  /// No description provided for @editSchedule.
  ///
  /// In en, this message translates to:
  /// **'Edit schedule'**
  String get editSchedule;

  /// No description provided for @noCourses.
  ///
  /// In en, this message translates to:
  /// **'No rides'**
  String get noCourses;

  /// No description provided for @tapToAddCourse.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to add a course'**
  String get tapToAddCourse;

  /// No description provided for @course.
  ///
  /// In en, this message translates to:
  /// **'Ride'**
  String get course;

  /// No description provided for @addCourse.
  ///
  /// In en, this message translates to:
  /// **'Add ride'**
  String get addCourse;

  /// No description provided for @editCourse.
  ///
  /// In en, this message translates to:
  /// **'Edit ride'**
  String get editCourse;

  /// No description provided for @setTime.
  ///
  /// In en, this message translates to:
  /// **'Set time'**
  String get setTime;

  /// No description provided for @noSchedules.
  ///
  /// In en, this message translates to:
  /// **'No schedules'**
  String get noSchedules;

  /// No description provided for @allTypes.
  ///
  /// In en, this message translates to:
  /// **'All types'**
  String get allTypes;

  /// No description provided for @allRoutes.
  ///
  /// In en, this message translates to:
  /// **'All routes'**
  String get allRoutes;

  /// No description provided for @schedules.
  ///
  /// In en, this message translates to:
  /// **'Schedules'**
  String get schedules;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Error occurred. Check your Internet connection'**
  String get errorOccurred;

  /// No description provided for @areYouSureDeleteSchedule.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this schedule ({schedule})?'**
  String areYouSureDeleteSchedule(Object schedule);

  /// No description provided for @variant.
  ///
  /// In en, this message translates to:
  /// **'Variant'**
  String get variant;

  /// No description provided for @stopTimes.
  ///
  /// In en, this message translates to:
  /// **'Stop times'**
  String get stopTimes;

  /// No description provided for @busRoute.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get busRoute;

  /// No description provided for @variants.
  ///
  /// In en, this message translates to:
  /// **'Variants'**
  String get variants;

  /// No description provided for @addRoute.
  ///
  /// In en, this message translates to:
  /// **'Add bus route'**
  String get addRoute;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

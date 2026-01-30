// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome to BusFinder!';

  @override
  String get personalTravelAssistant => 'Your personal travel assistant';

  @override
  String get login => 'Log in';

  @override
  String get singup => 'Sign up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'First name';

  @override
  String get surname => 'Last name';

  @override
  String get timetables => 'Timetables';

  @override
  String get map => 'Map';

  @override
  String get profile => 'Profile';

  @override
  String get hello => 'Hello!';

  @override
  String get general => 'General';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get logout => 'Log out';

  @override
  String get adminOptions => 'Administrator options';

  @override
  String get users => 'Users';

  @override
  String get stops => 'Bus stops';

  @override
  String get lines => 'Bus lines';

  @override
  String get selectUserType => 'Select user type';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String areYouSureDeleteUser(Object user) {
    return 'Are you sure you want to delete this user ($user)?';
  }

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String areYouSureDeleteStop(Object stop) {
    return 'Are you sure you want to delete this bus stop ($stop)?';
  }

  @override
  String get addStop => 'Add bus stop';

  @override
  String get editStop => 'Edit bus stop';

  @override
  String get next => 'Next';

  @override
  String get stopName => 'Bus stop name';

  @override
  String get mainRoute => 'Main route';

  @override
  String get allVariants => 'All variants';

  @override
  String get workday => 'Workday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get holiday => 'Holiday';

  @override
  String get special => 'Special';

  @override
  String get noSchedulesAvailable => 'No schedules available for this stop.';

  @override
  String get noBusesAtThisStop => 'No buses at this stop for this schedule.';

  @override
  String get legend => 'Legend';

  @override
  String get selectRoute => 'Select route';

  @override
  String get locationDisabled => 'Location services are disabled.';

  @override
  String get permissionsDenied => 'Location permissions are denied.';

  @override
  String get permissionsDeniedPermanently =>
      'Location permissions are permanently denied.';

  @override
  String get drivingStarted => 'Driving started.';

  @override
  String locationSent(Object datetime) {
    return 'Location sent at $datetime';
  }

  @override
  String get drivingStopped => 'Driving stopped.';

  @override
  String get stopDriving => 'Stop driving';

  @override
  String get startDriving => 'Start driving';

  @override
  String get driver => 'Driver';

  @override
  String get save => 'Save';

  @override
  String get error => 'Error';

  @override
  String get routeName => 'Bus route name';

  @override
  String get addVariant => 'Add variant';

  @override
  String get editVariant => 'Edit variant';

  @override
  String get variantName => 'Variant name';

  @override
  String get busRoutes => 'Bus routes';

  @override
  String areYouSureDeleteRoute(Object route) {
    return 'Are you sure you want to delete this route ($route)?';
  }

  @override
  String get editRoute => 'Edit route';

  @override
  String nStops(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stops',
      one: '1 stop',
      zero: 'No stops',
    );
    return '$_temp0';
  }

  @override
  String get standard => 'Standard';

  @override
  String get addSchedule => 'Add schedule';

  @override
  String get dayType => 'Day type';

  @override
  String get editSchedule => 'Edit schedule';

  @override
  String get noCourses => 'No rides';

  @override
  String get tapToAddCourse => 'Tap the + button to add a course';

  @override
  String get course => 'Ride';

  @override
  String get addCourse => 'Add ride';

  @override
  String get editCourse => 'Edit ride';

  @override
  String get setTime => 'Set time';

  @override
  String get noSchedules => 'No schedules';

  @override
  String get allTypes => 'All types';

  @override
  String get allRoutes => 'All routes';

  @override
  String get schedules => 'Schedules';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get errorOccurred => 'Error occurred. Check your Internet connection';

  @override
  String areYouSureDeleteSchedule(Object schedule) {
    return 'Are you sure you want to delete this schedule ($schedule)?';
  }

  @override
  String get variant => 'Variant';

  @override
  String get stopTimes => 'Stop times';

  @override
  String get busRoute => 'Route';

  @override
  String get variants => 'Variants';

  @override
  String get addRoute => 'Add bus route';
}

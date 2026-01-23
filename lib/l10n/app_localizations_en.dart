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
  String get name => 'Name';

  @override
  String get timetables => 'Timetables';

  @override
  String get map => 'Map';

  @override
  String get profile => 'Profile';

  @override
  String hello(Object name) {
    return 'Hello, $name!';
  }

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
}

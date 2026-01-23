// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get welcome => 'Witaj w aplikacji BusFinder!';

  @override
  String get personalTravelAssistant => 'Twój osobisty asystent podróży';

  @override
  String get login => 'Zaloguj się';

  @override
  String get singup => 'Zarejestruj się';

  @override
  String get email => 'Adres e-mail';

  @override
  String get password => 'Hasło';

  @override
  String get name => 'Imię';

  @override
  String get timetables => 'Rozkłady jazdy';

  @override
  String get map => 'Mapa';

  @override
  String get profile => 'Profil';

  @override
  String hello(Object name) {
    return 'Cześć, $name!';
  }

  @override
  String get general => 'Ogólne';

  @override
  String get theme => 'Motyw';

  @override
  String get language => 'Język';

  @override
  String get logout => 'Wyloguj się';

  @override
  String get adminOptions => 'Opcje administratora';

  @override
  String get users => 'Użytkownicy';

  @override
  String get stops => 'Przystanki';

  @override
  String get lines => 'Linie';

  @override
  String get selectUserType => 'Wybierz typ użytkownika';

  @override
  String get areYouSure => 'Czy na pewno?';

  @override
  String areYouSureDeleteUser(Object user) {
    return 'Czy na pewno chcesz usunąć tego użytkownika ($user)?';
  }

  @override
  String get yes => 'Tak';

  @override
  String get no => 'Nie';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Anuluj';

  @override
  String areYouSureDeleteStop(Object stop) {
    return 'Czy na pewno chcesz usunąć ten przystanek ($stop)?';
  }

  @override
  String get addStop => 'Dodaj przystanek';

  @override
  String get editStop => 'Edytuj przystanek';

  @override
  String get next => 'Dalej';

  @override
  String get stopName => 'Nazwa przystanku';
}

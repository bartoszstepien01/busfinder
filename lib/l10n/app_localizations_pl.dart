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
  String get surname => 'Nazwisko';

  @override
  String get timetables => 'Rozkłady jazdy';

  @override
  String get map => 'Mapa';

  @override
  String get profile => 'Profil';

  @override
  String get hello => 'Cześć!';

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

  @override
  String get mainRoute => 'Główna trasa';

  @override
  String get allVariants => 'Wszystkie warianty';

  @override
  String get workday => 'Dni robocze';

  @override
  String get saturday => 'Soboty';

  @override
  String get sunday => 'Niedziele';

  @override
  String get holiday => 'Święta';

  @override
  String get special => 'Specjalny';

  @override
  String get noSchedulesAvailable => 'Brak rozkładu dla tego przystanku.';

  @override
  String get noBusesAtThisStop => 'Ten rozkład nie obejmuje tego przystanku.';

  @override
  String get legend => 'Legenda';

  @override
  String get selectRoute => 'Wybierz linię';

  @override
  String get locationDisabled => 'Lokalizacja jest wyłączona.';

  @override
  String get permissionsDenied =>
      'Pozwolenie o dostęp do lokalizacji odrzucone.';

  @override
  String get permissionsDeniedPermanently =>
      'Pozwolenie o dostęp do lokalizacji permanentnie odrzucone.';

  @override
  String get drivingStarted => 'Rozpoczęto przejazd.';

  @override
  String locationSent(Object datetime) {
    return 'Lokalizacja wysłana. Czas: $datetime';
  }

  @override
  String get drivingStopped => 'Zakończono przejazd.';

  @override
  String get stopDriving => 'Zakończ przejazd';

  @override
  String get startDriving => 'Rozpocznij przejazd';

  @override
  String get driver => 'Kierowca';

  @override
  String get save => 'Zapisz';

  @override
  String get error => 'Błąd';

  @override
  String get routeName => 'Nazwa linii';

  @override
  String get addVariant => 'Dodaj wariant';

  @override
  String get editVariant => 'Edytuj wariant';

  @override
  String get variantName => 'Nazwa wariantu';

  @override
  String get busRoutes => 'Linie autobusowe';

  @override
  String areYouSureDeleteRoute(Object route) {
    return 'Czy na pewno chcesz usunąć tę linię ($route)?';
  }

  @override
  String get editRoute => 'Edytuj linię';

  @override
  String nStops(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count przystanka',
      many: '$count przystanków',
      few: '$count przystanki',
      one: '$count przystanek',
    );
    return '$_temp0';
  }

  @override
  String get standard => 'Standardowy';

  @override
  String get addSchedule => 'Dodaj rozkład';

  @override
  String get dayType => 'Rodzaj dnia';

  @override
  String get editSchedule => 'Edytuj rozkład';

  @override
  String get noCourses => 'Brak przejazdów';

  @override
  String get tapToAddCourse => 'Kliknij przycisk +, aby dodać przejazd';

  @override
  String get course => 'Przejazd';

  @override
  String get addCourse => 'Dodaj przejazd';

  @override
  String get editCourse => 'Edytuj przejazd';

  @override
  String get setTime => 'Ustaw czas';

  @override
  String get noSchedules => 'Brak rozkładów';

  @override
  String get allTypes => 'Wszystkie rodzaje';

  @override
  String get allRoutes => 'Wszystkie linie';

  @override
  String get schedules => 'Rozkłady jazdy';

  @override
  String get system => 'Systemowy';

  @override
  String get light => 'Jasny';

  @override
  String get dark => 'Ciemny';

  @override
  String get errorOccurred =>
      'Wystąpił błąd. Sprawdź swoje połączenie z internetem';

  @override
  String areYouSureDeleteSchedule(Object schedule) {
    return 'Czy na pewno chcesz usunąć ten rozkład ($schedule)?';
  }

  @override
  String get variant => 'Wariant';

  @override
  String get stopTimes => 'Godziny postojów';

  @override
  String get busRoute => 'Linia';

  @override
  String get variants => 'Warianty';

  @override
  String get addRoute => 'Dodaj linię';
}

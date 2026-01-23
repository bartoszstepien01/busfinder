import 'package:busfinder/api_service.dart';
import 'package:busfinder/bloc/authentication_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthenticationCubit extends HydratedCubit<AuthenticationState> {
  final ApiService api;

  AuthenticationCubit(this.api) : super(const NotLoggedIn()) {
    _syncApiWithState(state);
  }

  void logIn(String token, UserType userType) {
    emit(LoggedIn(token: token, userType: userType));
  }

  void logOut() {
    emit(NotLoggedIn());
  }

  @override
  void onChange(Change<AuthenticationState> change) {
    super.onChange(change);
    _syncApiWithState(change.nextState);
  }

  void _syncApiWithState(AuthenticationState state) {
    switch (state) {
      case LoggedIn(:final token):
        api.setToken(token);
      case NotLoggedIn():
        api.setToken('');
    }
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    if (!json['loggedIn']) {
      return NotLoggedIn();
    }

    return LoggedIn(
      token: json['token'],
      userType: UserType.values[json['userType']]
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return switch (state) {
      NotLoggedIn() => {
        'loggedIn': false,
        'token': null,
        'userType': null
      },
      final LoggedIn loggedInState => {
        'loggedIn': true,
        'token': loggedInState.token,
        'userType': loggedInState.userType.index
      }
    };
  }
}

sealed class AuthenticationState {
  const AuthenticationState();
}

class NotLoggedIn extends AuthenticationState {
  const NotLoggedIn();
}

enum UserType { user, driver, admin }

class LoggedIn extends AuthenticationState {
  const LoggedIn({required this.token, required this.userType});

  final String token;
  final UserType userType;
}

abstract class UserEvent {
  const UserEvent();
}

class SignInEvent implements UserEvent {
  final String username;
  final String password;

  const SignInEvent({
    required this.username,
    required this.password,
  });
}

class LogoutEvent implements UserEvent {
  const LogoutEvent();
}

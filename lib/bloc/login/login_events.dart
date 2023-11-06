abstract class LoginEvent {}

class SignInEvent extends LoginEvent {}

class UpdateLoginEvent extends LoginEvent {
  UpdateLoginEvent({required this.login});

  final String login;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateLoginEvent &&
          runtimeType == other.runtimeType &&
          login == other.login;

  @override
  int get hashCode => login.hashCode;
}

class UpdatePasswordEvent extends LoginEvent {
  UpdatePasswordEvent({required this.password});

  final String password;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdatePasswordEvent &&
          runtimeType == other.runtimeType &&
          password == other.password;

  @override
  int get hashCode => password.hashCode;
}

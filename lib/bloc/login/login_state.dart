enum LoginStatus {
  none,
  loading,
  success;

  bool get isLoading => this == loading;

  bool get isSuccess => this == success;
}

class LoginState {
  final String login;
  final String password;
  final LoginStatus status;
  final bool isLoginEnabled;

  const LoginState({
    this.login = '',
    this.password = '',
    this.status = LoginStatus.none,
    this.isLoginEnabled = false,
  });

  const LoginState.init() : this();

  LoginState copyWith({
    String? login,
    String? password,
    LoginStatus? status,
    bool? isLoginEnabled,
  }) {
    return LoginState(
      login: login ?? this.login,
      password: password ?? this.password,
      status: status ?? this.status,
      isLoginEnabled: isLoginEnabled ?? this.isLoginEnabled,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          login == other.login &&
          password == other.password &&
          status == other.status &&
          isLoginEnabled == other.isLoginEnabled;

  @override
  int get hashCode =>
      login.hashCode ^
      password.hashCode ^
      status.hashCode ^
      isLoginEnabled.hashCode;
}

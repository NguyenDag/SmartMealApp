import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String username;
  final String password;
  final String? usernameError;
  final String? passwordError;
  final String? generalError;

  const LoginState({
    this.status = LoginStatus.initial,
    this.username = '',
    this.password = '',
    this.usernameError,
    this.passwordError,
    this.generalError,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? username,
    String? password,
    String? usernameError,
    String? passwordError,
    String? generalError,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      usernameError: usernameError,
      passwordError: passwordError,
      generalError: generalError,
    );
  }

  bool get isFormValid =>
      username.isNotEmpty &&
      usernameError == null &&
      password.isNotEmpty &&
      passwordError == null;

  @override
  List<Object?> get props => [
    status,
    username,
    password,
    usernameError,
    passwordError,
    generalError,
  ];
}

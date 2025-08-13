import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  final String fullName;
  final String employeeId;
  final String username;
  final String password;

  const RegisterRequest({
    required this.fullName,
    required this.employeeId,
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [fullName, employeeId, username, password];
}

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class FullNameChanged extends RegisterEvent {
  final String fullName;

  const FullNameChanged(this.fullName);

  @override
  List<Object> get props => [fullName];
}

class EmployeeIdChanged extends RegisterEvent {
  final String employeeId;

  const EmployeeIdChanged(this.employeeId);

  @override
  List<Object> get props => [employeeId];
}

class UsernameChanged extends RegisterEvent {
  final String username;

  const UsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}

class BackToLoginPressed extends RegisterEvent {
  const BackToLoginPressed();
}

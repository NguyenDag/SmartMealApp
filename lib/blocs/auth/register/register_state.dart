import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String fullName;
  final String employeeId;
  final String username;
  final String password;
  final String? errorMessage;
  final Map<String, String> fieldErrors;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.fullName = '',
    this.employeeId = '',
    this.username = '',
    this.password = '',
    this.errorMessage,
    this.fieldErrors = const {},
  });

  bool get isFormValid {
    return fullName.isNotEmpty &&
        employeeId.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty &&
        password.length >= 6;
  }

  RegisterState copyWith({
    RegisterStatus? status,
    String? fullName,
    String? employeeId,
    String? username,
    String? password,
    String? errorMessage,
    Map<String, String>? fieldErrors,
  }) {
    return RegisterState(
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      employeeId: employeeId ?? this.employeeId,
      username: username ?? this.username,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      fieldErrors: fieldErrors ?? this.fieldErrors,
    );
  }

  @override
  List<Object?> get props => [
    status,
    fullName,
    employeeId,
    username,
    password,
    errorMessage,
    fieldErrors,
  ];
}

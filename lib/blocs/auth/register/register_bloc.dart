import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_meal/blocs/auth/register/register_event.dart';
import 'package:smart_meal/blocs/auth/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<FullNameChanged>(_onFullNameChanged);
    on<EmployeeIdChanged>(_onEmployeeIdChanged);
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<BackToLoginPressed>(_onBackToLoginPressed);
  }

  void _onFullNameChanged(FullNameChanged event, Emitter<RegisterState> emit) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);
    if (event.fullName.isEmpty) {
      fieldErrors['fullName'] = 'Tên đầy đủ không được để trống';
    } else {
      fieldErrors.remove('fullName');
    }

    emit(state.copyWith(fullName: event.fullName, fieldErrors: fieldErrors));
  }

  void _onEmployeeIdChanged(
    EmployeeIdChanged event,
    Emitter<RegisterState> emit,
  ) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);
    if (event.employeeId.isEmpty) {
      fieldErrors['employeeId'] = 'Mã nhân viên không được để trống';
    } else {
      fieldErrors.remove('employeeId');
    }

    emit(
      state.copyWith(employeeId: event.employeeId, fieldErrors: fieldErrors),
    );
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<RegisterState> emit) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);
    if (event.username.isEmpty) {
      fieldErrors['username'] = 'Tên tài khoản không được để trống';
    } else {
      fieldErrors.remove('username');
    }

    emit(state.copyWith(username: event.username, fieldErrors: fieldErrors));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);
    if (event.password.isEmpty) {
      fieldErrors['password'] = 'Mật khẩu không được để trống';
    } else if (event.password.length < 6) {
      fieldErrors['password'] = 'Mật khẩu phải có ít nhất 6 ký tự';
    } else {
      fieldErrors.remove('password');
    }

    emit(state.copyWith(password: event.password, fieldErrors: fieldErrors));
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (!state.isFormValid) {
      final fieldErrors = <String, String>{};

      if (state.fullName.isEmpty) {
        fieldErrors['fullName'] = 'Tên đầy đủ không được để trống';
      }
      if (state.employeeId.isEmpty) {
        fieldErrors['employeeId'] = 'Mã nhân viên không được để trống';
      }
      if (state.username.isEmpty) {
        fieldErrors['username'] = 'Tên tài khoản không được để trống';
      }
      if (state.password.isEmpty) {
        fieldErrors['password'] = 'Mật khẩu không được để trống';
      } else if (state.password.length < 6) {
        fieldErrors['password'] = 'Mật khẩu phải có ít nhất 6 ký tự';
      }

      emit(state.copyWith(fieldErrors: fieldErrors));
      return;
    }

    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate validation for unique username and employee ID
      if (state.username.toLowerCase() == 'admin' ||
          state.username.toLowerCase() == 'user') {
        emit(
          state.copyWith(
            status: RegisterStatus.failure,
            errorMessage: 'Tên tài khoản đã được sử dụng',
          ),
        );
        return;
      }

      if (state.employeeId == '12345' || state.employeeId == '67890') {
        emit(
          state.copyWith(
            status: RegisterStatus.failure,
            errorMessage: 'Mã nhân viên đã được sử dụng',
          ),
        );
        return;
      }

      // Success case
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: 'Đăng ký thất bại. Vui lòng thử lại.',
        ),
      );
    }
  }

  void _onBackToLoginPressed(
    BackToLoginPressed event,
    Emitter<RegisterState> emit,
  ) {
    // Navigation will be handled in the UI layer
  }
}

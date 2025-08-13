import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/register/register_bloc.dart';
import '../blocs/auth/register/register_event.dart';
import '../blocs/auth/register/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _fullNameController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _employeeIdController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đăng ký thành công!'),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate back to login after success
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
          } else if (state.status == RegisterStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Đăng ký thất bại'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Stack(
          children: [
            // Background image
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image_register.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black26, Colors.transparent],
                  ),
                ),
              ),
            ),
            // Content
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Back button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<RegisterBloc>().add(
                                const BackToLoginPressed(),
                              );
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.all(8),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  Text(
                                    'Quay lại',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Form container
                    Transform.translate(
                      offset: const Offset(0, -30),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 30,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  const Center(
                                    child: Text(
                                      'Tạo tài khoản mới',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF00AD23),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  const Divider(
                                    color: Colors.green,
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 18),
                                  // Full Name Field
                                  _buildTextField(
                                    controller: _fullNameController,
                                    label: 'Tên đầy đủ',
                                    placeholder: 'Tên đầy đủ',
                                    errorText: state.fieldErrors['fullName'],
                                    onChanged: (value) {
                                      context.read<RegisterBloc>().add(
                                        FullNameChanged(value),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  // Employee ID Field
                                  _buildTextField(
                                    controller: _employeeIdController,
                                    label: 'Mã nhân viên',
                                    placeholder: 'Mã nhân viên',
                                    errorText: state.fieldErrors['employeeId'],
                                    onChanged: (value) {
                                      context.read<RegisterBloc>().add(
                                        EmployeeIdChanged(value),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  // Username Field
                                  _buildTextField(
                                    controller: _usernameController,
                                    label: 'Tên tài khoản',
                                    placeholder: 'Tên tài khoản',
                                    errorText: state.fieldErrors['username'],
                                    onChanged: (value) {
                                      context.read<RegisterBloc>().add(
                                        UsernameChanged(value),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  // Password Field
                                  _buildTextField(
                                    controller: _passwordController,
                                    label: 'Mật khẩu',
                                    placeholder: 'Mật khẩu',
                                    isPassword: true,
                                    errorText: state.fieldErrors['password'],
                                    onChanged: (value) {
                                      context.read<RegisterBloc>().add(
                                        PasswordChanged(value),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 32),
                                  // Register Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed:
                                          state.status == RegisterStatus.loading
                                              ? null
                                              : () {
                                                context
                                                    .read<RegisterBloc>()
                                                    .add(
                                                      const RegisterSubmitted(),
                                                    );
                                              },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF00A1CD,
                                        ),
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child:
                                          state.status == RegisterStatus.loading
                                              ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.white),
                                                ),
                                              )
                                              : const Text(
                                                'Đăng ký',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String placeholder,
    required Function(String) onChanged,
    String? errorText,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 12),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.black,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : const Color(0xFF00BCD4),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
          ),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

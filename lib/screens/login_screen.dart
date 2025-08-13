import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/login/login_bloc.dart';
import '../blocs/auth/login/login_event.dart';
import '../blocs/auth/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginButtonPressed() {
    context.read<LoginBloc>().add(
      LoginSubmitted(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _navigateToForgotPassword() {
    Navigator.of(context).pushNamed('/forgot-password');
  }

  void _navigateToCreateAccount() {
    Navigator.of(context).pushNamed('/create-account');
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String placeholder,
    required bool isPassword,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: errorText != null ? Colors.red : Colors.grey.shade300,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          // AC1: Successful login - redirect to main screen
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image_login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black26,
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Header
                            const Text(
                              'Xin chào!',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily: 'Roboto',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Đăng nhập để tiếp tục',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),

                            // General error message
                            if (state.generalError != null)
                              Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.red.shade200,
                                  ),
                                ),
                                child: Text(
                                  state.generalError!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                            // Username field
                            _buildTextField(
                              controller: _usernameController,
                              placeholder: 'Tên đăng nhập',
                              isPassword: false,
                              errorText: state.usernameError,
                            ),
                            const SizedBox(height: 16),

                            // Password field
                            _buildTextField(
                              controller: _passwordController,
                              placeholder: 'Mật khẩu',
                              isPassword: true,
                              errorText: state.passwordError,
                            ),
                            const SizedBox(height: 24),

                            // Login button
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed:
                                    state.status == LoginStatus.loading
                                        ? null
                                        : _onLoginButtonPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00A1CD),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                child:
                                    state.status == LoginStatus.loading
                                        ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                        : const Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Forgot password link
                            TextButton(
                              onPressed: _navigateToForgotPassword,
                              child: const Text(
                                'Quên mật khẩu?',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            Divider(color: Colors.black, thickness: 1),

                            const SizedBox(height: 8),

                            // Create account button
                            FractionallySizedBox(
                              widthFactor: 0.82,
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ElevatedButton(
                                  onPressed: _navigateToCreateAccount,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade600,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Tạo tài khoản mới',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
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
            ),
          ),
        ),
      ),
    );
  }
}

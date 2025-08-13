import 'package:flutter/material.dart';
import 'package:smart_meal/screens/login_screen.dart';
import 'package:smart_meal/screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: LoginScreen(),
      routes: {
      //   '/home': (context) => HomeScreen(),
      //   '/forgot-password': (context) => ForgotPasswordScreen(),
        '/create-account': (context) => RegisterScreen(),
      },
    );
  }
}


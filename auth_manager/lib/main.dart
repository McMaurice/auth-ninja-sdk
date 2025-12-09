import 'package:flutter/material.dart';
import 'package:auth_ninja_sdk/src/presentation/auth_screen.dart';
import 'package:auth_ninja_sdk/src/core/auth_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Ninja SDK Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AuthScreen(
        initialMode: AuthMode.signup,
        config: AuthConfig(
          loginTitle: 'Login to Your Account',
          signUpTitle: 'Create Account',
          loginButtonText: 'Sign In',
          signUpButtonText: 'Sign Up',
          enableGoogleAuth: true,
          enableAppleAuth: true,
          
        ),
      ),
    );
  }
}

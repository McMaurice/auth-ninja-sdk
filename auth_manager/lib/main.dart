import 'package:flutter/material.dart';
import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Ninja SDK Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AuthNinjaScreen(
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

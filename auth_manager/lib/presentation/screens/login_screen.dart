import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthNinjaScreen(
      config: AuthNinjaConfig(
        enableEmailAuth: true,
        enableAppleAuth: true,
        enableGoogleAuth: true,
        enableFacebookAuth: false,
        loginButtonText: 'Login',
        signUpButtonText: 'Sign Up',
        loginTitle: 'Login',
        signUpTitle: 'Sign Up',
        logoAssetPath: 'assets/defaultimage.png',
        logoheight: 200,
        logowidth: 200
        // More customizations
      ),
    );
  }
}

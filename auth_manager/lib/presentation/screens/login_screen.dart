import 'package:auth_manager/main.dart';
import 'package:auth_manager/presentation/screens/home_screen.dart';
import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This returns our default log in screen with exceptions handled
    return AuthNinjaScreen(
      config: const AuthNinjaConfig(
        enableEmailAuth: true,
        enableAppleAuth: true,
        enableGoogleAuth: true,
        enableFacebookAuth: false,
        loginButtonText: 'Log in',
        signUpButtonText: 'Sign Up',
        loginTitle: 'Log into the Vibe',
        signUpTitle: 'Sign Up for a bumpy ride!',
        logoAssetPath: 'assets/defaultimage.png',
        logoheight: 200,
        logowidth: 100,
      ),
      onEmailLoginSuccess: () {
        _navigateToHome();
      },
      onEmailSignUpSuccess: () {
        _navigateToHome();
      },
      onGooglePressed: () async {
        await ninja.signInWithGoogle();
        _navigateToHome();
      },
      onApplePressed: () async {
        await ninja.signInWithApple();
        _navigateToHome();
      },
    );
  }
}

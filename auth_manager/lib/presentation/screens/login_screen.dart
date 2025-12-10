import 'package:auth_manager/presentation/screens/home_screen.dart';
import 'package:auth_manager/presentation/screens/set_up.dart';
import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const HomeScreen()),
        );
      },

      onEmailSignUpSuccess: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const SetUp()),
        );
      },
      onGooglePressed: () async {
        final ninja = AuthNinja.instance;
        await ninja.signInWithGoogle();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const HomeScreen()),
        );
      },
      onApplePressed: () async {
        final ninja = AuthNinja.instance;
        await ninja.signInWithApple();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const HomeScreen()),
        );
      },
    );
  }
}

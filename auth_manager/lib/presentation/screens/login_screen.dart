import 'package:auth_manager/main.dart';
import 'package:auth_manager/presentation/screens/home_screen.dart';
import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  void navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const HomeScreen()),
    );
  }


  void _showError(BuildContext context, AuthNinjaException e) {
    String message;

    if (e is InvalidCredentialsException) {
      message = 'Wrong email or password, please try banner .';
    } else if (e is UserNotFoundException) {
      message = 'No user found for that email.';
    } else if (e is EmailAlreadyInUseException) {
      message = 'The email is already in use by another account.';
    } else if (e is WeakPasswordException) {
      message = 'Password is too weak.';
    } else if (e is InvalidEmailException) {
      message = 'The email address is not valid.';
    } else if (e is NetworkException) {
      message = 'No internet connection. Check your network.';
    } else if (e is GoogleSignInCancelledException || e is AppleSignInCancelledException) {
      message = 'Sign-in cancelled by user.';
    } else {
      message = e.message;
    }


  AuthNinjaErrorBanner.show(
    context: context,
    errorMessage: message,
  );
}




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

      // Email login
      onEmailPasswordSubmit: (email, password) async {
        if (!context.mounted) return;
        try {
          await ninja.signInWithEmail(email, password);
          navigateToHome(context);
        } 
        on AuthNinjaException catch (e) {
          _showError(context, e);
        } catch (e) {
          _showError(context, UnknownAuthException(e.toString()));
        }
      },

      // Email signup
      onEmailPasswordSignUpSubmit: (email, password) async {
        if (!context.mounted) return;
        try {
          await ninja.signUpWithEmail(email, password);
          navigateToHome(context);
        } on AuthNinjaException catch (e) {
          _showError(context, e);
        } catch (e) {
          _showError(context, UnknownAuthException(e.toString()));
        }
      },

      // Google login
      onGooglePressed: () async {
        if (!context.mounted) return;
        try {
          await ninja.signInWithGoogle();
         navigateToHome(context);
        } on AuthNinjaException catch (e) {
          _showError(context, e);
        } catch (e) {
          _showError(context, UnknownAuthException(e.toString()));
        }
      },

      // Apple login
      onApplePressed: () async {
        if (!context.mounted) return;
        try {
          await ninja.signInWithApple();
         navigateToHome(context);
        } on AuthNinjaException catch (e) {
          _showError(context, e);
        } catch (e) {
          _showError(context, UnknownAuthException(e.toString()));
        }
      },
    );
  }
}
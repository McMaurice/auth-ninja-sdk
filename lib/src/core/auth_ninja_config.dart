import 'package:flutter/material.dart';

class AuthNinjaConfig {
  final bool enableEmailAuth;
  final bool enableGoogleAuth;
  final bool enableAppleAuth;
  final bool enableFacebookAuth;

  final String? appName;
  final String? logoAssetPath;

  final Color? primaryColor;
  final Color? accentColor;

  final TextStyle? titleTextStyle;
  final TextStyle? buttonTextStyle;

  final String loginTitle;
  final String signUpTitle;
  final String emailHint;
  final String passwordHint;
  final String loginButtonText;
  final String signUpButtonText;

  const AuthNinjaConfig({
    this.enableEmailAuth = true,
    this.enableGoogleAuth = true,
    this.enableAppleAuth = true,
    this.enableFacebookAuth = true,
    this.appName,
    this.logoAssetPath,
    this.primaryColor,
    this.accentColor,
    this.titleTextStyle,
    this.buttonTextStyle,
    this.loginTitle = 'Welcome Back',
    this.signUpTitle = 'Create Account',
    this.emailHint = 'Email',
    this.passwordHint = 'Password',
    this.loginButtonText = 'Sign In',
    this.signUpButtonText = 'Sign Up',
  });
}

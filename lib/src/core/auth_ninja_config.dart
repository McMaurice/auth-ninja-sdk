import 'package:flutter/material.dart';
 
class AuthNinjaConfig {
  // Enabled auth methods
 final bool enableEmailAuth;
 final bool enableGoogleAuth;
 final bool enableAppleAuth;
 final bool enableFacebookAuth;
 
 // UI Configuration
 final String? appName;
 final String? logoAssetPath;
 final double? logoheight;
  final double? logowidth;
 final Color? primaryColor;
 final Color? accentColor;
 final TextStyle? titleTextStyle;
 final TextStyle? buttonTextStyle;
 
 
 // Custom messages
 final String loginTitle;
 final String signUpTitle;
 final String emailHint;
 final String passwordHint;
 final String loginButtonText;
 final String signUpButtonText;
 final String? designImage;
 

 const AuthNinjaConfig({
    this.enableEmailAuth = true,
    this.enableGoogleAuth = true,
    this.enableAppleAuth = true,
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
    required this.enableFacebookAuth,
    this.designImage,
    this.logoheight,
    this.logowidth,
  });
 
}
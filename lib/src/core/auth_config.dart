import 'package:flutter/material.dart';
 
class AuthConfig {
  // Enabled auth methods
 final bool enableEmailAuth;
 final bool enableGoogleAuth;
 final bool enableAppleAuth;
 
 // UI Configuration
 final String? appName;
 final String? logoAssetPath;
 final Color? primaryColor;
 final Color? accentColor;
 final TextStyle? titleTextStyle;
 final TextStyle? buttonTextStyle;
 
 // Terms and Privacy
 final String? termsUrl;
 final String? privacyUrl;
 
 // Custom messages
 final String loginTitle;
 final String signUpTitle;
 final String emailHint;
 final String passwordHint;
 final String loginButtonText;
 final String signUpButtonText;
 final List<CustomFormField>? signupCustomFields;

 const AuthConfig({
   this.enableEmailAuth = true,
   this.enableGoogleAuth = true,
   this.enableAppleAuth = true,
   this.appName,
   this.logoAssetPath,
   this.primaryColor,
   this.accentColor,
   this.titleTextStyle,
   this.buttonTextStyle,
   this.termsUrl,
   this.privacyUrl,
   this.loginTitle = 'Welcome Back',
   this.signUpTitle = 'Create Account',
   this.emailHint = 'Email',
   this.passwordHint = 'Password',
   this.loginButtonText = 'Sign In',
   this.signUpButtonText = 'Sign Up',
   this.signupCustomFields,
 });
 
 AuthConfig copyWith({
   bool? enableEmailAuth,
   bool? enableGoogleAuth,
   bool? enableAppleAuth,
   String? appName,
   String? logoAssetPath,
   Color? primaryColor,
   Color? accentColor,
   TextStyle? titleTextStyle,
   TextStyle? buttonTextStyle,
   String? termsUrl,
   String? privacyUrl,
   String? loginTitle,
   String? signUpTitle,
   String? emailHint,
   String? passwordHint,
   String? loginButtonText,
   String? signUpButtonText,
 }) {
   return AuthConfig(
     enableEmailAuth: enableEmailAuth ?? this.enableEmailAuth,
     enableGoogleAuth: enableGoogleAuth ?? this.enableGoogleAuth,
     enableAppleAuth: enableAppleAuth ?? this.enableAppleAuth,
     appName: appName ?? this.appName,
     logoAssetPath: logoAssetPath ?? this.logoAssetPath,
     primaryColor: primaryColor ?? this.primaryColor,
     accentColor: accentColor ?? this.accentColor,
     titleTextStyle: titleTextStyle ?? this.titleTextStyle,
     buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
     termsUrl: termsUrl ?? this.termsUrl,
     privacyUrl: privacyUrl ?? this.privacyUrl,
     loginTitle: loginTitle ?? this.loginTitle,
     signUpTitle: signUpTitle ?? this.signUpTitle,
     emailHint: emailHint ?? this.emailHint,
     passwordHint: passwordHint ?? this.passwordHint,
     loginButtonText: loginButtonText ?? this.loginButtonText,
     signUpButtonText: signUpButtonText ?? this.signUpButtonText,
   );
 }
}

class CustomFormField {
  final String label;
  final String hint;
  final String fieldName;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final bool isRequired;

  CustomFormField({
    required this.label,
    required this.hint,
    required this.fieldName,
    this.validator,
    this.inputType = TextInputType.text,
    this.isRequired = false,
  });
}
import 'package:flutter/material.dart';

class AuthTheme {
  final Color primaryColor;
  final Color accentColor;
  final TextStyle titleStyle;
  final TextStyle buttonTextStyle;
  final EdgeInsetsGeometry formPadding;

  const AuthTheme({
    required this.primaryColor,
    required this.accentColor,
    required this.titleStyle,
    required this.buttonTextStyle,
    this.formPadding = const EdgeInsets.symmetric(horizontal: 24),
  });

  factory AuthTheme.defaultTheme() {
    return const AuthTheme(
      primaryColor: Colors.blue,
      accentColor: Colors.blueAccent,
      titleStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      buttonTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  AuthTheme copyWith({
    Color? primaryColor,
    Color? accentColor,
    TextStyle? titleStyle,
    TextStyle? buttonTextStyle,
    EdgeInsetsGeometry? formPadding,
  }) {
    return AuthTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      titleStyle: titleStyle ?? this.titleStyle,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      formPadding: formPadding ?? this.formPadding,
    );
  }
}
import 'package:flutter/material.dart';

/*
CUSTOMIZES THE LOG INFO THAT THE SDK THROWS
 */
class AuthNinjaLogger {
  final bool isDebugMode;

  AuthNinjaLogger({this.isDebugMode = true});

  void info(String message) {
    if (isDebugMode) {
      debugPrint('[AuthSDK] $message');
    }
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[AuthSDK ERROR] $message');
    if (error != null) {
      debugPrint('Error details: $error');
    }
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  void warning(String message) {
    if (isDebugMode) {
      debugPrint('[AuthSDK WARNING] $message');
    }
  }
}

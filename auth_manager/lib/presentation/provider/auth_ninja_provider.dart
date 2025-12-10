import 'package:auth_manager/presentation/provider/auth_ninja_notifier.dart';
import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter_riverpod/legacy.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
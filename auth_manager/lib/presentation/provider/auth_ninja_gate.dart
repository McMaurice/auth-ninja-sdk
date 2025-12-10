import 'package:auth_manager/presentation/provider/auth_ninja_provider.dart';
import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AuthGate extends ConsumerWidget {
  final Widget home;
  final Widget login;

  const AuthGate({super.key, required this.home, required this.login});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    switch (authState.status) {
      case AuthNinjaStatus.authenticated:
        return home;
      case AuthNinjaStatus.unauthenticated:
        return login;
      case AuthNinjaStatus.loading:
      case AuthNinjaStatus.tokenExpired:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
    }
  }
}
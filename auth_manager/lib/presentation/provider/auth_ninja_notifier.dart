import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.unauthenticated()) {
    
    _init();
  }

  void _init() {
    AuthNinja.instance.authStateChanges.listen((state) {
      
      this.state = state;
    });
  }
}
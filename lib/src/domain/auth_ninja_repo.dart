import 'package:auth_ninja_sdk/src/core/auth_ninja_service.dart';
import 'package:auth_ninja_sdk/src/core/auth_ninja_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthNinjaRepository {
  final AuthNinjaService _authService;

  AuthNinjaRepository({AuthNinjaService? authService})
      : _authService = authService ?? AuthNinjaService();

  Stream<AuthState> get authStateChanges => _authService.authStateChanges;

  User? get currentUser => _authService.currentUser;

  Future<AuthState> signInWithEmail(String email, String password) async {
    return await _authService.signInWithEmail(email, password);
  }

  Future<AuthState> signUpWithEmail(
    String email,
    String password, {
    String? displayName,
  }) async {
    return await _authService.signUpWithEmail(
      email,
      password,
      displayName: displayName,
    );
  }

  Future<AuthState> signInWithGoogle() async {
    return await _authService.signInWithGoogle();
  }

  Future<AuthState> signInWithApple() async {
    return await _authService.signInWithApple();
  }

  Future<AuthState> signInWithFacebook() async {
    return await _authService.signInWithFacebook();
  }

  Future<void> signOut() async {
    return await _authService.signOut();
  }

  Future<void> resetPassword(String email) async {
    return await _authService.resetPassword(email);
  }

  Future<bool> isTokenExpired() async {
    return await _authService.isTokenExpired();
  }

  Future<void> refreshToken() async {
    return await _authService.refreshToken();
  }

  String? get currentProviderId => _authService.currentProviderId;

  bool isSignedInWith(String providerId) {
    return _authService.isSignedInWith(providerId);
  }

  bool isSignedInWithFacebook() {
    return _authService.isSignedInWith('facebook.com');
  }
}

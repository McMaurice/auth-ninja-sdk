import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:auth_ninja_sdk/src/core/auth_ninja_exceptions.dart';
import 'package:flutter_riverpod/legacy.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthNinja _authNinja = AuthNinja.instance;
  
  AuthNotifier() : super(AuthState.unauthenticated()) {
    // Listen to SDK's auth state changes
    _authNinja.authStateChanges.listen(_handleAuthStateChange);
  }
  
  void _handleAuthStateChange(AuthState authState) {
  // Only update if the new state is authenticated OR
  // if we're not currently loading (to avoid overriding loading state)
  if (authState.status == AuthNinjaStatus.authenticated || 
      state.status != AuthNinjaStatus.loading) {
    state = authState;
  }
}

  // Email/Password Sign In
  Future<void> signInWithEmail(String email, String password) async {
    // Set loading state - UI automatically updates
    state = AuthState.loading();
    
    try {
      final result = await _authNinja.signInWithEmail(email, password);
      
      if (result.status == AuthNinjaStatus.authenticated) {
        // Success - state already updated by _handleAuthStateChange
      } else {
        // SDK returned an error state
        state = AuthState.error(result.errorMessage ?? 'Sign in failed');
      }
    } on AuthNinjaException catch (e) {
      // Your custom exceptions
      state = AuthState.error(e.message);
    } catch (e) {
      // Unexpected errors
      state = AuthState.error('An unexpected error occurred');
    }
  }

  // Sign Up with Email
  Future<void> signUpWithEmail(String email, String password, {String? displayName}) async {
    state = AuthState.loading();
    
    try {
      final result = await _authNinja.signUpWithEmail(
        email, 
        password, 
        displayName: displayName,
      );
      
      if (result.status == AuthNinjaStatus.authenticated) {
        // Success
      } else {
        state = AuthState.error(result.errorMessage ?? 'Sign up failed');
      }
    } on AuthNinjaException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = AuthState.error('An unexpected error occurred');
    }
  }

  // Google Sign In
  Future<void> signInWithGoogle() async {
    state = AuthState.loading();
    
    try {
      final result = await _authNinja.signInWithGoogle();
      
      if (result.status == AuthNinjaStatus.authenticated) {
        // Success
      } else {
        state = AuthState.error(result.errorMessage ?? 'Google sign in failed');
      }
    } on AuthNinjaException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = AuthState.error('Google sign in failed');
    }
  }

  // Apple Sign In
  Future<void> signInWithApple() async {
    state = AuthState.loading();
    
    try {
      final result = await _authNinja.signInWithApple();
      
      if (result.status == AuthNinjaStatus.authenticated) {
        // Success
      } else {
        state = AuthState.error(result.errorMessage ?? 'Apple sign in failed');
      }
    } on AuthNinjaException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = AuthState.error('Apple sign in failed');
    }
  }

  // Facebook Sign In
  Future<void> signInWithFacebook() async {
    state = AuthState.loading();
    
    try {
      final result = await _authNinja.signInWithFacebook();
      
      if (result.status == AuthNinjaStatus.authenticated) {
        // Success
      } else {
        state = AuthState.error(result.errorMessage ?? 'Facebook sign in failed');
      }
    } on AuthNinjaException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = AuthState.error('Facebook sign in failed');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    state = AuthState.loading();
    
    try {
      await _authNinja.signOut();
      state = AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error('Failed to sign out');
    }
  }

  // Clear Error
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }
  }
}
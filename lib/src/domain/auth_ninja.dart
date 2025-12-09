import 'package:auth_ninja_sdk/src/core/auth_ninja_state.dart';
import 'package:auth_ninja_sdk/src/domain/auth_ninja_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Main entry point for AuthNinja SDK
/// 
/// Use this class to interact with authentication features.
/// Can be used with or without the default UI components.
/// 
/// Example usage:
/// ```dart
/// // Initialize (typically in main.dart)
/// final authManager = AuthNinjaManager.instance;
/// 
/// // Sign in programmatically
/// await authManager.signInWithEmail('user@example.com', 'password');
/// 
/// // Listen to auth state
/// authManager.authStateChanges.listen((state) {
///   if (state is Authenticated) {
///     print('User signed in: ${state.user.email}');
///   }
/// });
/// ```
class AuthNinja {
  static AuthNinja? _instance;
  final AuthNinjaRepository _repository;

  AuthNinja._internal({AuthNinjaRepository? repository})
      : _repository = repository ?? AuthNinjaRepository();

  /// Singleton instance of AuthNinjaManager
  static AuthNinja get instance {
    _instance ??= AuthNinja._internal();
    return _instance!;
  }

  /// Initialize with custom repository (useful for testing)
  static void initialize({AuthNinjaRepository? repository}) {
    _instance = AuthNinja._internal(repository: repository);
  }

  /// Reset the instance (useful for testing)
  static void reset() {
    _instance = null;
  }

  // ==================== Auth State ====================

  /// Stream of authentication state changes
  /// 
  /// Listen to this stream to react to auth state changes:
  /// ```dart
  /// authManager.authStateChanges.listen((state) {
  ///   if (state is Authenticated) {
  ///     // User is signed in
  ///   } else if (state is Unauthenticated) {
  ///     // User is signed out
  ///   } else if (state is AuthError) {
  ///     // Handle error
  ///   }
  /// });
  /// ```
  Stream<AuthState> get authStateChanges => _repository.authStateChanges;

  /// Get the currently signed-in user
  User? get currentUser => _repository.currentUser;

  /// Check if a user is currently signed in
  bool get isSignedIn => currentUser != null;

  /// Get the current user's email
  String? get currentUserEmail => currentUser?.email;

  /// Get the current user's display name
  String? get currentUserDisplayName => currentUser?.displayName;

  /// Get the current user's photo URL
  String? get currentUserPhotoUrl => currentUser?.photoURL;

  /// Get the current user's UID
  String? get currentUserId => currentUser?.uid;

  // ==================== Email/Password Auth ====================

  /// Sign in with email and password
  /// 
  /// Returns [AuthState] indicating success or failure.
  /// 
  /// Example:
  /// ```dart
  /// final state = await authManager.signInWithEmail(
  ///   'user@example.com',
  ///   'password123',
  /// );
  /// 
  /// if (state is Authenticated) {
  ///   print('Success: ${state.user.email}');
  /// } else if (state is AuthError) {
  ///   print('Error: ${state.message}');
  /// }
  /// ```
  Future<AuthState> signInWithEmail(String email, String password) async {
    return await _repository.signInWithEmail(email, password);
  }

  /// Sign up with email and password
  /// 
  /// Optionally provide a [displayName] for the new user.
  /// 
  /// Example:
  /// ```dart
  /// final state = await authManager.signUpWithEmail(
  ///   'newuser@example.com',
  ///   'password123',
  ///   displayName: 'John Doe',
  /// );
  /// ```
  Future<AuthState> signUpWithEmail(
    String email,
    String password, {
    String? displayName,
  }) async {
    return await _repository.signUpWithEmail(
      email,
      password,
      displayName: displayName,
    );
  }

  /// Send password reset email
  /// 
  /// Example:
  /// ```dart
  /// await authManager.resetPassword('user@example.com');
  /// ```
  Future<void> resetPassword(String email) async {
    return await _repository.resetPassword(email);
  }

  // ==================== Social Auth ====================

  /// Sign in with Google
  /// 
  /// Example:
  /// ```dart
  /// final state = await authManager.signInWithGoogle();
  /// ```
  Future<AuthState> signInWithGoogle() async {
    return await _repository.signInWithGoogle();
  }

  /// Sign in with Apple
  /// 
  /// Example:
  /// ```dart
  /// final state = await authManager.signInWithApple();
  /// ```
  Future<AuthState> signInWithApple() async {
    return await _repository.signInWithApple();
  }

  /// Sign in with Facebook
  /// 
  /// Example:
  /// ```dart
  /// final state = await authManager.signInWithFacebook();
  /// ```
  Future<AuthState> signInWithFacebook() async {
    return await _repository.signInWithFacebook();
  }

  // ==================== Sign Out ====================

  /// Sign out the current user
  /// 
  /// Example:
  /// ```dart
  /// await authManager.signOut();
  /// ```
  Future<void> signOut() async {
    return await _repository.signOut();
  }

  // ==================== Token Management ====================

  /// Check if the current user's token is expired
  Future<bool> isTokenExpired() async {
    return await _repository.isTokenExpired();
  }

  /// Refresh the current user's token
  Future<void> refreshToken() async {
    return await _repository.refreshToken();
  }

  // ==================== Provider Info ====================

  /// Get the current provider ID (e.g., 'google.com', 'password', etc.)
  String? get currentProviderId => _repository.currentProviderId;

  /// Check if user is signed in with a specific provider
  /// 
  /// Example:
  /// ```dart
  /// if (authManager.isSignedInWith('google.com')) {
  ///   print('User signed in with Google');
  /// }
  /// ```
  bool isSignedInWith(String providerId) {
    return _repository.isSignedInWith(providerId);
  }

  /// Check if user is signed in with Google
  bool get isSignedInWithGoogle => isSignedInWith('google.com');

  /// Check if user is signed in with Apple
  bool get isSignedInWithApple => isSignedInWith('apple.com');

  /// Check if user is signed in with Facebook
  bool get isSignedInWithFacebook => _repository.isSignedInWithFacebook();

  /// Check if user is signed in with email/password
  bool get isSignedInWithEmailPassword => isSignedInWith('password');

  // ==================== Convenience Methods ====================

  /// Quick check and refresh token if needed
  /// 
  /// Returns true if token is valid or was successfully refreshed.
  /// 
  /// Example:
  /// ```dart
  /// if (await authManager.ensureValidToken()) {
  ///   // Token is valid, proceed with API calls
  /// } else {
  ///   // Token invalid, user needs to sign in again
  /// }
  /// ```
  Future<bool> ensureValidToken() async {
    if (!isSignedIn) return false;
    
    if (await isTokenExpired()) {
      try {
        await refreshToken();
        return true;
      } catch (e) {
        return false;
      }
    }
    return true;
  }

  /// Get a map of user info for easy serialization
  /// 
  /// Example:
  /// ```dart
  /// final userInfo = authManager.getCurrentUserInfo();
  /// print(userInfo); // {uid: '123', email: 'user@example.com', ...}
  /// ```
  Map<String, dynamic>? getCurrentUserInfo() {
    final user = currentUser;
    if (user == null) return null;

    return {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
      'phoneNumber': user.phoneNumber,
      'emailVerified': user.emailVerified,
      'isAnonymous': user.isAnonymous,
      'providerId': currentProviderId,
    };
  }
}
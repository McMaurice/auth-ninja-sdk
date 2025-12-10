/*
HOLDS THE STATE OF OUR SKD SERVICES AND THE MODELS IN THE STATE
 */
enum AuthNinjaStatus {
  authenticated,
  unauthenticated,
  tokenExpired,
  loading,
}

class AuthState {
  final AuthNinjaStatus status;
  final String? userId;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.userId,
    this.email,
    this.displayName,
    this.photoUrl,
    this.errorMessage,
  });

  factory AuthState.unauthenticated() {
    return const AuthState(status: AuthNinjaStatus.unauthenticated);
  }

  factory AuthState.authenticated({
    required String userId,
    String? email,
    String? displayName,
    String? photoUrl,
  }) {
    return AuthState(
      status: AuthNinjaStatus.authenticated,
      userId: userId,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  factory AuthState.tokenExpired() {
    return const AuthState(status: AuthNinjaStatus.tokenExpired);
  }

  factory AuthState.loading() {
    return const AuthState(status: AuthNinjaStatus.loading);
  }
 
  
 
  factory AuthState.error(String errorMessage) {
    return AuthState(
      status: AuthNinjaStatus.unauthenticated,
      errorMessage: errorMessage,
    );
  }
  
  
  bool get isLoading => status == AuthNinjaStatus.loading;

  bool get isAuthenticated => status == AuthNinjaStatus.authenticated;

  bool get isTokenExpired => status == AuthNinjaStatus.tokenExpired;

  bool get isUnauthenticated => status == AuthNinjaStatus.unauthenticated;
  
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;


  AuthState copyWith({
    AuthNinjaStatus? status,
    String? userId,
    String? email,
    String? displayName,
    String? photoUrl,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}


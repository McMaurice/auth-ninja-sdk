/* 
USED BY PROVIDERS TO MAP TO OUR SDK CUSTOM ERRORS
*/
abstract class AuthNinjaException implements Exception {
  final String message;
  final String code;

  AuthNinjaException(this.message, this.code);

  @override
  String toString() => message;
}

// Email & Password Exceptions
class InvalidCredentialsException extends AuthNinjaException {
  InvalidCredentialsException()
      : super('Wrong email or password', 'invalid-credentials');
}

class UserNotFoundException extends AuthNinjaException {
  UserNotFoundException()
      : super('No account exists with this email', 'user-not-found');
}

class EmailAlreadyInUseException extends AuthNinjaException {
  EmailAlreadyInUseException()
      : super('An account already exists with this email',
            'email-already-in-use');
}

class WeakPasswordException extends AuthNinjaException {
  WeakPasswordException()
      : super(
            'Password is too weak. Use at least 6 characters', 'weak-password');
}

class InvalidEmailException extends AuthNinjaException {
  InvalidEmailException()
      : super('The email address is not valid', 'invalid-email');
}

class UserDisabledException extends AuthNinjaException {
  UserDisabledException()
      : super('This account has been disabled', 'user-disabled');
}

class TooManyRequestsException extends AuthNinjaException {
  TooManyRequestsException()
      : super('Too many attempts. Please try again later', 'too-many-requests');
}

class OperationNotAllowedException extends AuthNinjaException {
  OperationNotAllowedException()
      : super('This operation is not allowed', 'operation-not-allowed');
}

// Token & Session Exceptions
class TokenExpiredException extends AuthNinjaException {
  TokenExpiredException()
      : super(
            'Your session has expired. Please sign in again', 'token-expired');
}

class InvalidTokenException extends AuthNinjaException {
  InvalidTokenException()
      : super('Invalid authentication token', 'invalid-token');
}

// Network Exceptions
class NetworkException extends AuthNinjaException {
  NetworkException()
      : super('Network error. Please check your connection', 'network-error');
}

// Google Sign-In Exceptions
class GoogleSignInCancelledException extends AuthNinjaException {
  GoogleSignInCancelledException()
      : super('Google sign-in was cancelled', 'google-sign-in-cancelled');
}

class GoogleSignInFailedException extends AuthNinjaException {
  GoogleSignInFailedException([String? details])
      : super(
            details != null
                ? 'Google sign-in failed: $details'
                : 'Google sign-in failed',
            'google-sign-in-failed');
}

class GoogleAccountNotFoundException extends AuthNinjaException {
  GoogleAccountNotFoundException()
      : super('No Google account selected', 'google-account-not-found');
}

// Facebook Sign-In Exceptions
class FacebookSignInCancelledException extends AuthNinjaException {
  FacebookSignInCancelledException()
      : super('Facebook sign-in was cancelled', 'facebook-sign-in-cancelled');
}

class FacebookSignInFailedException extends AuthNinjaException {
  FacebookSignInFailedException([String? details])
      : super(
            details != null
                ? 'Facebook sign-in failed: $details'
                : 'Facebook sign-in failed',
            'facebook-sign-in-failed');
}

class FacebookAccessTokenException extends AuthNinjaException {
  FacebookAccessTokenException()
      : super('Failed to get Facebook access token',
            'facebook-access-token-failed');
}

class FacebookPermissionDeniedException extends AuthNinjaException {
  FacebookPermissionDeniedException()
      : super('Facebook permissions were denied', 'facebook-permission-denied');
}

// Apple Sign-In Exceptions
class AppleSignInCancelledException extends AuthNinjaException {
  AppleSignInCancelledException()
      : super('Apple sign-in was cancelled', 'apple-sign-in-cancelled');
}

class AppleSignInFailedException extends AuthNinjaException {
  AppleSignInFailedException([String? details])
      : super(
            details != null
                ? 'Apple sign-in failed: $details'
                : 'Apple sign-in failed',
            'apple-sign-in-failed');
}

class AppleCredentialException extends AuthNinjaException {
  AppleCredentialException()
      : super('Failed to get Apple credentials', 'apple-credential-failed');
}

// Account Linking Exceptions
class AccountExistsWithDifferentCredentialException extends AuthNinjaException {
  AccountExistsWithDifferentCredentialException()
      : super(
            'An account already exists with the same email but different sign-in credentials',
            'account-exists-with-different-credential');
}

class CredentialAlreadyInUseException extends AuthNinjaException {
  CredentialAlreadyInUseException()
      : super('This credential is already associated with a different account',
            'credential-already-in-use');
}

// Generic Exception
class UnknownAuthException extends AuthNinjaException {
  UnknownAuthException(String message) : super(message, 'unknown-error');
}

class AuthExceptionHandler {
  static AuthNinjaException handleFirebaseError(dynamic error) {
    final errorCode = error.code?.toString() ?? '';
    final errorMessage = error.message?.toString() ?? '';

    switch (errorCode) {
      // Email & Password errors
      case 'wrong-password':
      case 'invalid-credential':
        return InvalidCredentialsException();
      case 'user-not-found':
        return UserNotFoundException();
      case 'email-already-in-use':
        return EmailAlreadyInUseException();
      case 'weak-password':
        return WeakPasswordException();
      case 'invalid-email':
        return InvalidEmailException();
      case 'user-disabled':
        return UserDisabledException();
      case 'too-many-requests':
        return TooManyRequestsException();
      case 'operation-not-allowed':
        return OperationNotAllowedException();

      // Token & Session errors
      case 'user-token-expired':
      case 'id-token-expired':
        return TokenExpiredException();
      case 'invalid-token':
      case 'invalid-user-token':
        return InvalidTokenException();

      // Network errors
      case 'network-request-failed':
        return NetworkException();

      // Account linking errors
      case 'account-exists-with-different-credential':
        return AccountExistsWithDifferentCredentialException();
      case 'credential-already-in-use':
        return CredentialAlreadyInUseException();

      // Google-specific errors
      case 'google-sign-in-cancelled':
        return GoogleSignInCancelledException();
      case 'google-sign-in-failed':
        return GoogleSignInFailedException(errorMessage);

      // Facebook-specific errors
      case 'facebook-sign-in-cancelled':
        return FacebookSignInCancelledException();
      case 'facebook-sign-in-failed':
        return FacebookSignInFailedException(errorMessage);

      // Apple-specific errors
      case 'apple-sign-in-cancelled':
        return AppleSignInCancelledException();
      case 'apple-sign-in-failed':
        return AppleSignInFailedException(errorMessage);

      default:
        return UnknownAuthException(errorMessage.isNotEmpty
            ? errorMessage
            : 'An unexpected error occurred');
    }
  }

  /// Handle Google Sign-In specific errors
  static AuthNinjaException handleGoogleError(dynamic error) {
    if (error == null) {
      return GoogleSignInCancelledException();
    }

    final errorString = error.toString().toLowerCase();

    if (errorString.contains('cancel')) {
      return GoogleSignInCancelledException();
    } else if (errorString.contains('network')) {
      return NetworkException();
    } else if (errorString.contains('account')) {
      return GoogleAccountNotFoundException();
    }

    return GoogleSignInFailedException(error.toString());
  }

  /// Handle Facebook Sign-In specific errors
  static AuthNinjaException handleFacebookError(dynamic error) {
    if (error == null) {
      return FacebookSignInCancelledException();
    }

    final errorString = error.toString().toLowerCase();

    if (errorString.contains('cancel')) {
      return FacebookSignInCancelledException();
    } else if (errorString.contains('network')) {
      return NetworkException();
    } else if (errorString.contains('permission')) {
      return FacebookPermissionDeniedException();
    } else if (errorString.contains('token')) {
      return FacebookAccessTokenException();
    }

    return FacebookSignInFailedException(error.toString());
  }

  /// Handle Apple Sign-In specific errors
  static AuthNinjaException handleAppleError(dynamic error) {
    if (error == null) {
      return AppleSignInCancelledException();
    }

    final errorString = error.toString().toLowerCase();

    if (errorString.contains('cancel') || errorString.contains('1001')) {
      return AppleSignInCancelledException();
    } else if (errorString.contains('credential')) {
      return AppleCredentialException();
    } else if (errorString.contains('network')) {
      return NetworkException();
    }

    return AppleSignInFailedException(error.toString());
  }
}

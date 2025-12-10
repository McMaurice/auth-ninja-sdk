class AppValidators {
  // Email validation
  static String? email(String? value, {bool isRequired = true}) {
    if (isRequired && (value == null || value.isEmpty)) {
      return 'Please enter your email address';
    }
    
    if (value != null && value.isNotEmpty) {
      // More comprehensive email regex
      final emailRegex = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
      );
      
      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email address';
      }
    }
    
    return null;
  }

  // Password validation with configurable rules
  static String? password(
    String? value, {
    bool isRequired = true,
    bool isSignUpMode = false,
    int minLength = 8,
    bool requireUppercase = false,
    bool requireLowercase = false,
    bool requireNumbers = false,
    bool requireSpecialChars = false,
  }) {
    if (isRequired && (value == null || value.isEmpty)) {
      return isSignUpMode 
          ? 'Please create a password'
          : 'Please enter your password';
    }
    
    if (value == null) return null;
    
    // Length check
    if (isSignUpMode && value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    
    // Additional security rules for signup
    if (isSignUpMode) {
      final errors = <String>[];
      
      if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
        errors.add('uppercase letter');
      }
      
      if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
        errors.add('lowercase letter');
      }
      
      if (requireNumbers && !value.contains(RegExp(r'[0-9]'))) {
        errors.add('number');
      }
      
      if (requireSpecialChars && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        errors.add('special character');
      }
      
      if (errors.isNotEmpty) {
        return 'Password must contain at least ${errors.join(', ')}';
      }
    }
    
    return null;
  }

  // Confirm password validation
  static String? confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  // Name validation
  static String? name(String? value, {bool isRequired = true}) {
    if (isRequired && (value == null || value.isEmpty)) {
      return 'Please enter your name';
    }
    
    if (value != null && value.isNotEmpty) {
      // Allow letters, spaces, hyphens, and apostrophes
      final nameRegex = RegExp(r"^[a-zA-Zà-ÿÀ-Ÿ '-]+$");
      
      if (!nameRegex.hasMatch(value)) {
        return 'Please enter a valid name';
      }
      
      if (value.length < 2) {
        return 'Name must be at least 2 characters';
      }
    }
    
    return null;
  }

  // Phone number validation
  static String? phoneNumber(String? value, {bool isRequired = true}) {
    if (isRequired && (value == null || value.isEmpty)) {
      return 'Please enter your phone number';
    }
    
    if (value != null && value.isNotEmpty) {
      // Remove all non-digit characters
      final digits = value.replaceAll(RegExp(r'\D'), '');
      
      // Basic validation - adjust based on country
      if (digits.length < 10) {
        return 'Please enter a valid phone number';
      }
    }
    
    return null;
  }

  // Generic required field validator
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Minimum length validator
  static String? minLength(String? value, int min, {String fieldName = 'Field'}) {
    if (value != null && value.length < min) {
      return '$fieldName must be at least $min characters';
    }
    return null;
  }

  // Max length validator
  static String? maxLength(String? value, int max, {String fieldName = 'Field'}) {
    if (value != null && value.length > max) {
      return '$fieldName must be less than $max characters';
    }
    return null;
  }
}
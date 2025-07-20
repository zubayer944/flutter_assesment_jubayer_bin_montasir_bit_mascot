class FieldValidator {
  /// Validates email format
  /// Returns null if valid, error message if invalid
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Please enter your email address';
    }

    // Email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    if (!emailRegex.hasMatch(email.trim())) {
      return 'Please enter a valid email address';
    }

    return null; // Valid email
  }

  /// Validates password strength
  /// Returns null if valid, error message if invalid
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (password.length > 50) {
      return 'Password must be less than 50 characters';
    }

    return null; // Valid password
  }

  /// Validates both email and password
  /// Returns map with validation results
  static Map<String, String?> validateLoginFields({
    required String? email,
    required String? password,
  }) {
    return {
      'email': validateEmail(email),
      'password': validatePassword(password),
    };
  }

  /// Checks if all validation results are null (all valid)
  static bool isAllValid(Map<String, String?> validationResults) {
    return validationResults.values.every((error) => error == null);
  }

  /// Gets first error message from validation results
  static String? getFirstError(Map<String, String?> validationResults) {
    for (String? error in validationResults.values) {
      if (error != null) {
        return error;
      }
    }
    return null;
  }
} 
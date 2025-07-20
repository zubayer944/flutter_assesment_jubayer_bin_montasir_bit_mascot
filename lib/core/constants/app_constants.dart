class AppConstants {
  // App Information
  static const String appName = 'Flutter Assessment';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'A Flutter assessment project with clean architecture';

  // API Endpoints
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/v1';
  
  // Authentication endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';
  
  // User endpoints
  static const String userProfileEndpoint = '/user/profile';
  static const String updateProfileEndpoint = '/user/profile/update';
  
  // Content endpoints
  static const String homeDataEndpoint = '/home';
  static const String settingsEndpoint = '/settings';

  // HTTP Status Codes
  static const int successCode = 200;
  static const int createdCode = 201;
  static const int noContentCode = 204;
  static const int badRequestCode = 400;
  static const int unauthorizedCode = 401;
  static const int forbiddenCode = 403;
  static const int notFoundCode = 404;
  static const int serverErrorCode = 500;

  // Validation Constants
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 20;
  static const int maxEmailLength = 254;
  static const int maxNameLength = 100;

  // Regex Patterns
  static const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phoneRegex = r'^\+?[1-9]\d{1,14}$';
  static const String passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
  static const String onboardingKey = 'onboarding_completed';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultRadius = 8.0;
  static const double smallRadius = 4.0;
  static const double largeRadius = 16.0;

  // Error Messages
  static const String networkError = 'Network error occurred. Please check your connection.';
  static const String serverError = 'Server error occurred. Please try again later.';
  static const String unknownError = 'An unknown error occurred.';
  static const String invalidCredentials = 'Invalid email or password.';
  static const String emailAlreadyExists = 'Email already exists.';
  static const String weakPassword = 'Password is too weak.';
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String fieldRequired = 'This field is required.';

  // Success Messages
  static const String loginSuccess = 'Login successful!';
  static const String registerSuccess = 'Registration successful!';
  static const String logoutSuccess = 'Logout successful!';
  static const String profileUpdated = 'Profile updated successfully!';
  static const String settingsSaved = 'Settings saved successfully!';

  // Loading Messages
  static const String loading = 'Loading...';
  static const String processing = 'Processing...';
  static const String saving = 'Saving...';
  static const String updating = 'Updating...';

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayTimeFormat = 'hh:mm a';

  // File Upload
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedFileTypes = ['pdf', 'doc', 'docx', 'txt'];

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int minPageSize = 5;
} 
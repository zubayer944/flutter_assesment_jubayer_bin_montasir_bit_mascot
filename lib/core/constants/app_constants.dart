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

  // Regex Patterns
  static const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';


  // Success Messages
  static const String loginSuccess = 'Login successful!';

} 
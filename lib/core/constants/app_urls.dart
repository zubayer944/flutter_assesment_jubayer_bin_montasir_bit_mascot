class AppUrls {
  // Base URLs
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String apiVersion = '';
  static const String baseApiUrl = '$baseUrl$apiVersion';

  // Authentication URLs
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  // Utility Methods
  static String getFullUrl(String endpoint) {
    return '$baseApiUrl$endpoint';
  }


  // Environment-specific URLs
  static String getBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return 'https://dev-api.example.com';
      case 'staging':
        return 'https://staging-api.example.com';
      case 'prod':
      case 'production':
        return 'https://api.example.com';
      default:
        return baseUrl;
    }
  }

  // Placeholder Image URLs
  static const String placeholderBaseUrl = 'https://picsum.photos';
  
  static String getPlaceholderImageUrl(int width, int height, {int? id}) {
    if (id != null) {
      return '$placeholderBaseUrl/$width/$height?random=$id';
    }
    return '$placeholderBaseUrl/$width/$height';
  }


} 
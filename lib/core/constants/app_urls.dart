class AppUrls {
  // Base URLs
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String baseApiUrl = baseUrl;

  // Authentication URLs
  static const String login = '/auth/login';

  // Utility Methods
  static String getFullUrl(String endpoint) {
    return '$baseApiUrl$endpoint';
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
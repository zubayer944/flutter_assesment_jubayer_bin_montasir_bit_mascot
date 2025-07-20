import 'package:dio/dio.dart' as http;
import 'package:get/get.dart';
import '../../config/app_config.dart';
import '../../errors/failures.dart';
import '../../../shared/services/auth_service.dart';
import '../../storage/storage_service.dart';

class AppInterceptor extends http.Interceptor {
  @override
  void onRequest(http.RequestOptions options, http.RequestInterceptorHandler handler) {
    _handleRequestLogging(options);
    _handleAuthentication(options);
    handler.next(options);
  }

  @override
  void onResponse(http.Response response, http.ResponseInterceptorHandler handler) {
    _handleResponseLogging(response);
    handler.next(response);
  }

  @override
  void onError(http.DioException err, http.ErrorInterceptorHandler handler) {
    _handleErrorLogging(err);
    _handleGlobalError(err);
    handler.next(err);
  }

  // Authentication handling
  void _handleAuthentication(http.RequestOptions options) {
    try {
      final storageService = Get.find<StorageService>();
      final token = storageService.getToken();
      
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      // If storage service is not available, continue without token
    }
  }

  // Request logging
  void _handleRequestLogging(http.RequestOptions options) {
    if (AppConfig.isDebug) {
      print('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
      print('📤 Headers: ${options.headers}');
      if (options.data != null) {
        print('📦 Data: ${options.data}');
      }
      if (options.queryParameters.isNotEmpty) {
        print('🔍 Query: ${options.queryParameters}');
      }
    }
  }

  // Response logging
  void _handleResponseLogging(http.Response response) {
    if (AppConfig.isDebug) {
      print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      print('📥 Data: ${response.data}');
    }
  }

  // Error logging
  void _handleErrorLogging(http.DioException err) {
    if (AppConfig.isDebug) {
      print('❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
      print('🚨 Error Type: ${err.type}');
      print('📝 Error Message: ${err.message}');
      if (err.response?.data != null) {
        print('📥 Error Data: ${err.response?.data}');
      }
    }
  }

  // Global error handling
  void _handleGlobalError(http.DioException err) {
    // Handle 401 Unauthorized - Auto logout
    if (err.response?.statusCode == 401) {
      try {
        final authService = Get.find<AuthService>();
        authService.logout();
      } catch (e) {
        // If auth service is not available, just continue
      }
    }

    // Handle 403 Forbidden
    if (err.response?.statusCode == 403) {
      // You can add specific handling for forbidden access
    }

    // Handle 500+ Server errors
    if (err.response?.statusCode != null && err.response!.statusCode! >= 500) {
      // You can add server error analytics here
    }

    // Handle network errors
    if (err.type == http.DioExceptionType.connectionError) {
      // You can add network error handling here
    }

    // Handle timeout errors
    if (err.type == http.DioExceptionType.connectionTimeout ||
        err.type == http.DioExceptionType.sendTimeout ||
        err.type == http.DioExceptionType.receiveTimeout) {
      // You can add timeout handling here
    }
  }

  // Convert DioException to custom Failure
  Failure convertToFailure(http.DioException error) {
    switch (error.type) {
      case http.DioExceptionType.connectionTimeout:
      case http.DioExceptionType.sendTimeout:
      case http.DioExceptionType.receiveTimeout:
        return const TimeoutFailure(
          message: 'Request timeout. Please try again.',
        );
      case http.DioExceptionType.badResponse:
        return _handleResponseError(error.response);
      case http.DioExceptionType.cancel:
        return const UnknownFailure(
          message: 'Request was cancelled.',
        );
      case http.DioExceptionType.connectionError:
        return const NetworkFailure(
          message: 'No internet connection. Please check your network.',
        );
      default:
        return const UnknownFailure(
          message: 'An unexpected error occurred.',
        );
    }
  }

  // Handle HTTP response errors
  Failure _handleResponseError(http.Response? response) {
    final statusCode = response?.statusCode;
    final message = _extractErrorMessage(response);

    switch (statusCode) {
      case 400:
        return ValidationFailure(message: message);
      case 401:
        return AuthenticationFailure(message: message);
      case 403:
        return AuthorizationFailure(message: message);
      case 404:
        return NotFoundFailure(message: message);
      case 422:
        return ValidationFailure(message: message);
      case 429:
        return const TimeoutFailure(
          message: 'Too many requests. Please try again later.',
        );
      case 500:
        return ServerFailure(message: message);
      case 502:
      case 503:
      case 504:
        return ServerFailure(message: 'Server is temporarily unavailable.');
      default:
        return ServerFailure(message: message);
    }
  }

  // Extract error message from response
  String _extractErrorMessage(http.Response? response) {
    if (response?.data == null) {
      return 'Server error occurred.';
    }

    final data = response!.data;
    
    // Handle different response formats
    if (data is Map<String, dynamic>) {
      // Try different common error message fields
      return data['message'] ?? 
             data['error'] ?? 
             data['detail'] ?? 
             data['description'] ?? 
             'Server error occurred.';
    } else if (data is String) {
      return data;
    } else {
      return 'Server error occurred.';
    }
  }
} 
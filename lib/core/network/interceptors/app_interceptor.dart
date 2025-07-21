import 'package:dio/dio.dart' as dio;
import '../../errors/failures.dart';
import '../../storage/storage_service.dart';
import 'package:get/get.dart';

class AppInterceptor extends dio.Interceptor {
  final StorageService _storage;

  AppInterceptor(this._storage);

  @override
  void onRequest(dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    // Add authorization header if token exists
    final token = _storage.read<String>('token');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Add common headers
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    print('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
    print('🌐 REQUEST[${options.method}] => HEADERS: ${options.headers}');
    if (options.data != null) {
      print('🌐 REQUEST[${options.method}] => DATA: ${options.data}');
    }

    handler.next(options);
  }

  @override
  void onResponse(dio.Response response, dio.ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    // Handle specific error cases
    if (err.response?.statusCode == 401) {
      _handleUnauthorized();
    } else if (err.response?.statusCode == 403) {
      _handleForbidden();
    } else if (err.response?.statusCode == 404) {
      _handleNotFound();
    } else if (err.response?.statusCode == 500) {
      _handleServerError();
    } else if (err.type == dio.DioExceptionType.connectionTimeout ||
        err.type == dio.DioExceptionType.sendTimeout ||
        err.type == dio.DioExceptionType.receiveTimeout) {
      _handleGenericError(err);
    }

    // Convert error to Failure
    final failure = convertToFailure(err);
    handler.reject(err);
  }

  Failure convertToFailure(dio.DioException error) {
    String? message = error.response?.data['message'];
    String errorMessage = error.message ?? 'An unexpected error occurred';
    
    if (error.response?.statusCode == 401) {
      return AuthenticationFailure(message: message ?? 'Authentication failed');
    } else if (error.response?.statusCode == 404) {
      return NotFoundFailure(message: message ?? 'Resource not found');
    } else if (error.response?.statusCode == 422) {
      return ValidationFailure(message: message ?? 'Validation failed');
    } else if (error.response?.statusCode == 500) {
      return ServerFailure(message: message ?? 'Server error occurred');
    } else if (error.type == dio.DioExceptionType.connectionTimeout ||
        error.type == dio.DioExceptionType.sendTimeout ||
        error.type == dio.DioExceptionType.receiveTimeout) {
      return TimeoutFailure(message: errorMessage);
    } else {
      return UnknownFailure(message: errorMessage);
    }
  }

  void _handleUnauthorized() {
    // Clear authentication data
    _storage.remove('token');
    _storage.remove('refresh_token');
    _storage.remove('user_data');

    // Navigate to login screen
    Get.offAllNamed('/login');
  }

  void _handleForbidden() {
    // Show forbidden message
    Get.snackbar(
      'Access Denied',
      'You do not have permission to access this resource.',
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handleNotFound() {
    // Show not found message
    Get.snackbar(
      'Not Found',
      'The requested resource was not found.',
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handleServerError() {
    // Show server error message
    Get.snackbar(
      'Server Error',
      'An internal server error occurred. Please try again later.',
      snackPosition: SnackPosition.TOP,
    );
  }

  void _handleGenericError(dio.DioException err) {
    // Show generic error message
    String message = 'An error occurred. Please try again.';
    
    if (err.response?.data != null && err.response!.data is Map) {
      final data = err.response!.data as Map;
      message = data['message'] ?? data['error'] ?? message;
    }

    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
    );
  }
} 
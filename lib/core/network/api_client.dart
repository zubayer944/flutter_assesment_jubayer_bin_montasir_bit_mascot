import 'package:dio/dio.dart' as http;
import 'package:get/get.dart';
import '../config/app_config.dart';
import '../constants/app_urls.dart';
import '../errors/failures.dart';
import 'interceptors/app_interceptor.dart';
import '../storage/storage_service.dart';

class ApiClient {
  late http.Dio _dio;
  static ApiClient? _instance;

  ApiClient._() {
    _dio = http.Dio();
    _setupDio();
  }

  static ApiClient get instance {
    _instance ??= ApiClient._();
    return _instance!;
  }

  void _setupDio() {
    _dio.options = http.BaseOptions(
      baseUrl: AppUrls.baseApiUrl,
      connectTimeout: AppConfig.connectionTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    final storage = Get.find<StorageService>();
    _dio.interceptors.add(AppInterceptor(storage));
  }

  http.Dio get dio => _dio;

  Future<http.Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    http.Options? options,
    http.CancelToken? cancelToken,
    http.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on http.DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<http.Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    http.Options? options,
    http.CancelToken? cancelToken,
    http.ProgressCallback? onSendProgress,
    http.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on http.DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<http.Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    http.Options? options,
    http.CancelToken? cancelToken,
    http.ProgressCallback? onSendProgress,
    http.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on http.DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<http.Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    http.Options? options,
    http.CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on http.DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Failure _handleDioError(http.DioException error) {
    final storage = Get.find<StorageService>();
    return AppInterceptor(storage).convertToFailure(error);
  }
} 
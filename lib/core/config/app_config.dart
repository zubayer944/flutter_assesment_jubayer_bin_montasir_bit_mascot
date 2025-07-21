import 'package:flutter/material.dart';

enum Environment { dev, staging, production }

class AppConfig {
  static Environment _environment = Environment.dev;
  static String _apiBaseUrl = '';
  static String _appName = 'Flutter Assessment';
  static String _version = '1.0.0';
  static bool _isDebug = true;

  // Getters
  static Environment get environment => _environment;
  static String get apiBaseUrl => _apiBaseUrl;
  static String get appName => _appName;
  static String get version => _version;
  static bool get isDebug => _isDebug;

  // Initialize app configuration
  static void initialize({
    required Environment env,
    required String apiUrl,
    String? appName,
    String? version,
    bool? isDebug,
  }) {
    _environment = env;
    _apiBaseUrl = apiUrl;
    _appName = appName ?? _appName;
    _version = version ?? _version;
    _isDebug = isDebug ?? (env == Environment.dev);
  }


  // API configurations
  static Duration get connectionTimeout => const Duration(seconds: 30);
  static Duration get receiveTimeout => const Duration(seconds: 30);

  // Storage configurations
  static String get storageKey => 'flutter_assessment_storage';
} 
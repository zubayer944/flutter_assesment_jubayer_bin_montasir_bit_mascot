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

  // Environment specific configurations
  static bool get isDevelopment => _environment == Environment.dev;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.production;

  // API configurations
  static Duration get connectionTimeout => const Duration(seconds: 30);
  static Duration get receiveTimeout => const Duration(seconds: 30);
  static int get maxRetries => 3;

  // Storage configurations
  static String get storageKey => 'flutter_assessment_storage';
  static String get authTokenKey => 'auth_token';
  static String get userDataKey => 'user_data';
  static String get settingsKey => 'app_settings';

  // UI configurations
  static double get defaultPadding => 16.0;
  static double get defaultRadius => 8.0;
  static Duration get animationDuration => const Duration(milliseconds: 300);
  
  // Theme configurations
  static Color get primaryColor => const Color(0xFF2196F3);
  static Color get secondaryColor => const Color(0xFF03DAC6);
  static Color get errorColor => const Color(0xFFB00020);
  static Color get backgroundColor => const Color(0xFFF5F5F5);
} 
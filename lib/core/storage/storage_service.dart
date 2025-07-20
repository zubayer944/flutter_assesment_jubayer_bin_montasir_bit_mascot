import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';
import '../constants/app_constants.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // Token management
  Future<bool> setToken(String token) async {
    return await _prefs.setString(AppConstants.tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(AppConstants.tokenKey);
  }

  Future<bool> removeToken() async {
    return await _prefs.remove(AppConstants.tokenKey);
  }

  // Refresh token management
  Future<bool> setRefreshToken(String refreshToken) async {
    return await _prefs.setString(AppConstants.refreshTokenKey, refreshToken);
  }

  String? getRefreshToken() {
    return _prefs.getString(AppConstants.refreshTokenKey);
  }

  Future<bool> removeRefreshToken() async {
    return await _prefs.remove(AppConstants.refreshTokenKey);
  }

  // User data management
  Future<bool> setUserData(Map<String, dynamic> userData) async {
    return await _prefs.setString(AppConstants.userKey, jsonEncode(userData));
  }

  Map<String, dynamic>? getUserData() {
    final userDataString = _prefs.getString(AppConstants.userKey);
    if (userDataString != null) {
      return jsonDecode(userDataString) as Map<String, dynamic>;
    }
    return null;
  }

  Future<bool> removeUserData() async {
    return await _prefs.remove(AppConstants.userKey);
  }

  // Theme management
  Future<bool> setTheme(String theme) async {
    return await _prefs.setString(AppConstants.themeKey, theme);
  }

  String getTheme() {
    return _prefs.getString(AppConstants.themeKey) ?? 'light';
  }

  // Language management
  Future<bool> setLanguage(String language) async {
    return await _prefs.setString(AppConstants.languageKey, language);
  }

  String getLanguage() {
    return _prefs.getString(AppConstants.languageKey) ?? 'en';
  }

  // Onboarding management
  Future<bool> setOnboardingCompleted(bool completed) async {
    return await _prefs.setBool(AppConstants.onboardingKey, completed);
  }

  bool isOnboardingCompleted() {
    return _prefs.getBool(AppConstants.onboardingKey) ?? false;
  }

  // Generic storage methods
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // Object storage (JSON)
  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    return await _prefs.setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? getObject(String key) {
    final data = _prefs.getString(key);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  // Clear all data
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }

  // Remove specific key
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Check if key exists
  bool hasKey(String key) {
    return _prefs.containsKey(key);
  }

  // Get all keys
  Set<String> getKeys() {
    return _prefs.getKeys();
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return getToken() != null;
  }

  // Clear auth data
  Future<void> clearAuthData() async {
    await removeToken();
    await removeRefreshToken();
    await removeUserData();
  }
} 
import 'package:get/get.dart';
import 'package:flutter_assesment_jubayer_bit_mascot/core/storage/storage_service.dart';

class AuthService extends GetxService {
  final StorageService _storage = Get.find<StorageService>();
  
  // Observable variables
  final RxBool _isLoggedIn = false.obs;
  final RxMap<String, dynamic> _userData = <String, dynamic>{}.obs;
  
  // Getters
  bool get isLoggedIn => _isLoggedIn.value;
  Map<String, dynamic> get userData => _userData.value;
  
  @override
  void onInit() {
    super.onInit();
    _loadAuthState();
  }
  
  // Load authentication state from storage
  void _loadAuthState() {
    final token = _storage.read<String>('token');
    final userDataString = _storage.read<String>('user_data');
    
    _isLoggedIn.value = token != null;
    
    if (userDataString != null) {
      try {
        _userData.value = Map<String, dynamic>.from(userDataString as Map);
      } catch (e) {
        _userData.value = {};
      }
    }
  }
  
  // Login
  Future<bool> login(String token, String refreshToken, Map<String, dynamic> userData) async {
    try {
      await _storage.write('token', token);
      await _storage.write('refresh_token', refreshToken);
      await _storage.write('user_data', userData);
      
      _isLoggedIn.value = true;
      _userData.value = userData;
      
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Logout
  Future<bool> logout() async {
    try {
      await _storage.remove('token');
      await _storage.remove('refresh_token');
      await _storage.remove('user_data');
      
      _isLoggedIn.value = false;
      _userData.value = {};
      
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Get token
  String? getToken() {
    return _storage.read<String>('token');
  }
  
  // Get refresh token
  String? getRefreshToken() {
    return _storage.read<String>('refresh_token');
  }
  
  // Update user data
  Future<bool> updateUserData(Map<String, dynamic> userData) async {
    try {
      await _storage.write('user_data', userData);
      _userData.value = userData;
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Update token
  Future<bool> updateToken(String token) async {
    try {
      await _storage.write('token', token);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Update refresh token
  Future<bool> updateRefreshToken(String refreshToken) async {
    try {
      await _storage.write('refresh_token', refreshToken);
      return true;
    } catch (e) {
      return false;
    }
  }
} 
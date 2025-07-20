import 'package:get/get.dart';
import '../../core/storage/storage_service.dart';

class AuthService extends GetxService {
  final StorageService _storageService = Get.find<StorageService>();
  
  final RxBool _isLoggedIn = false.obs;
  final RxString _currentUser = ''.obs;

  bool get isLoggedIn => _isLoggedIn.value;
  String get currentUser => _currentUser.value;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    _isLoggedIn.value = _storageService.isLoggedIn();
    if (_isLoggedIn.value) {
      final userData = _storageService.getUserData();
      if (userData != null) {
        _currentUser.value = userData['email'] ?? '';
      }
    }
  }

  Future<void> login(String token, String refreshToken, Map<String, dynamic> userData) async {
    await _storageService.setToken(token);
    await _storageService.setRefreshToken(refreshToken);
    await _storageService.setUserData(userData);
    
    _isLoggedIn.value = true;
    _currentUser.value = userData['email'] ?? '';
  }

  Future<void> logout() async {
    await _storageService.clearAuthData();
    
    _isLoggedIn.value = false;
    _currentUser.value = '';
    
    // Navigate to login screen
    Get.offAllNamed('/login');
  }

  Future<void> refreshToken(String newToken, String newRefreshToken) async {
    await _storageService.setToken(newToken);
    await _storageService.setRefreshToken(newRefreshToken);
  }

  String? getToken() {
    return _storageService.getToken();
  }

  String? getRefreshToken() {
    return _storageService.getRefreshToken();
  }

  Map<String, dynamic>? getUserData() {
    return _storageService.getUserData();
  }

  void updateUserData(Map<String, dynamic> userData) {
    _storageService.setUserData(userData);
    _currentUser.value = userData['email'] ?? '';
  }
} 
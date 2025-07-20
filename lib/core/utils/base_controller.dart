import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../errors/failures.dart';

abstract class BaseController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxBool _hasError = false.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get hasError => _hasError.value;

  @override
  void onInit() {
    super.onInit();
    _resetState();
  }

  void _resetState() {
    _isLoading.value = false;
    _errorMessage.value = '';
    _hasError.value = false;
  }

  void setLoading(bool loading) {
    _isLoading.value = loading;
    if (loading) {
      _hasError.value = false;
      _errorMessage.value = '';
    }
  }

  void setError(String message) {
    _hasError.value = true;
    _errorMessage.value = message;
    _isLoading.value = false;
  }

  void clearError() {
    _hasError.value = false;
    _errorMessage.value = '';
  }

  void handleFailure(Failure failure) {
    setError(failure.message);
  }

  Future<void> execute(Future<void> Function() action) async {
    try {
      setLoading(true);
      await action();
    } catch (e) {
      if (e is Failure) {
        handleFailure(e);
      } else {
        setError(e.toString());
      }
    } finally {
      setLoading(false);
    }
  }

  void showSuccessMessage(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  void showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  void showInfoMessage(String message) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  void showLoadingDialog() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  void showConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  void showBottomSheet(Widget child) {
    Get.bottomSheet(
      child,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  void navigateTo(String route, {dynamic arguments}) {
    Get.toNamed(route, arguments: arguments);
  }

  void navigateToAndRemove(String route, {dynamic arguments}) {
    Get.offAllNamed(route, arguments: arguments);
  }

  void goBack() {
    Get.back();
  }

  void goBackTo(String route) {
    Get.until((route) => route.settings.name == route);
  }

  @override
  void onClose() {
    _resetState();
    super.onClose();
  }
} 
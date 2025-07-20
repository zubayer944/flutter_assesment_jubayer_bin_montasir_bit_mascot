import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../../../core/utils/base_controller.dart';
import '../../../../core/errors/failures.dart';

class AuthController extends BaseController {
  final LoginUseCase loginUseCase;

  AuthController({required this.loginUseCase});

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  // Password visibility
  final obscurePassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Set initial values for demo
    emailController.text = 'debra.holt@example.com';
    passwordController.text = 'password123';
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    // Validate form using Flutter's built-in validation
    if (!loginFormKey.currentState!.validate()) {
      return; // Form validation failed, don't proceed
    }

    await execute(() async {
      _handleLoginSuccess();
      // final result = await loginUseCase(LoginParams(
      //   email: emailController.text.trim(),
      //   password: passwordController.text,
      // ));

      // result.fold(
      //   (failure) {
      //     _handleLoginFailure(failure);
      //   },
      //   (user) {
      //     _handleLoginSuccess(user);
      //   },
      // );
    });
  }

  void _handleLoginFailure(Failure failure) {
    handleFailure(failure);
  }

  void _handleLoginSuccess() {
    // Store user data (you can use GetStorage or SharedPreferences)
    showSuccessMessage('Welcome back!');
    
    // Navigate to home page
    Get.offAllNamed('/home');
  }
} 
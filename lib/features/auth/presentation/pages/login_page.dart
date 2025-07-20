import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_sizes.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/field_validator.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              const Color(0xFFF0FFF4).withOpacity(0.4),
              const Color(0xFFEBF8FF).withOpacity(0.4),
            ],
            stops: const [0.0, 0.7, 0.85, 0.92, 0.96, 0.98, 0.99, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.w20),
            child: Column(
              children: [
                // Top spacing
                SizedBox(height: AppSizes.h60),

                // Logo Section
                _buildLogo(),

                SizedBox(height: AppSizes.h40),

                // Title Section
                _buildTitleSection(),

                SizedBox(height: AppSizes.h40),

                // Login Form
                _buildLoginForm(),

                SizedBox(height: AppSizes.h30),

                // Login Button
                _buildLoginButton(),

                SizedBox(height: AppSizes.h20),

                SizedBox(height: AppSizes.h20),

                // Forgot Password
                _buildForgotPassword(),

                SizedBox(height: AppSizes.h40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Container(
        width: AppSizes.w80,
        height: AppSizes.w80,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSizes.w20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main "W" shape
            Text(
              'W',
              style: TextStyle(
                color: Colors.white,
                fontSize: AppSizes.w32,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Cart wheels (dots)
            Positioned(
              bottom: AppSizes.w8,
              left: AppSizes.w12,
              child: Container(
                width: AppSizes.w4,
                height: AppSizes.w4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: AppSizes.w8,
              right: AppSizes.w12,
              child: Container(
                width: AppSizes.w4,
                height: AppSizes.w4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          'Log in to WebCommander',
          style: TextStyle(
            color: const Color(0xFF2D3748),
            fontSize: AppSizes.w24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSizes.h8),
        Text(
          'A complete eCommerce platform',
          style: TextStyle(
            color: const Color(0xFF718096),
            fontSize: AppSizes.w16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          // Email Field
          _buildInputField(
            label: 'Email Address',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          SizedBox(height: AppSizes.h24),

          // Password Field
          _buildInputField(
            label: 'Password',
            controller: controller.passwordController,
            isPassword: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText:
              isPassword ? this.controller.obscurePassword.value : false,
          style: TextStyle(
            fontSize: AppSizes.w16,
            color: const Color(0xFF2D3748),
          ),
          validator: (value) {
            if (isPassword) {
              return FieldValidator.validatePassword(value);
            } else {
              return FieldValidator.validateEmail(value);
            }
          },
                      decoration: InputDecoration(
              labelText: label,
              hintText: isPassword ? '********' : 'debra.holt@example.com',
              labelStyle: TextStyle(color: Colors.grey),
              hintStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.primary, width: 2.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        this.controller.obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFF718096),
                      ),
                      onPressed:
                          () => this.controller.togglePasswordVisibility(),
                    )
                    : null,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Obx(
      () => Container(
        width: double.infinity,
        height: AppSizes.h50,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSizes.w8),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSizes.w8),
            onTap: controller.isLoading ? null : controller.login,
            child: Center(
              child:
                  controller.isLoading
                      ? SizedBox(
                        width: AppSizes.w20,
                        height: AppSizes.w20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.w16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to forgot password page
        Get.snackbar(
          'Info',
          'Forgot password functionality coming soon!',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: AppSizes.w14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/field_validator.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: AppSizes.h80),

            _buildLogo(),
            SizedBox(height: AppSizes.h20),

            _buildTitleSection(),
            SizedBox(height: AppSizes.getResponsiveHeight(10)),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.w20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLoginForm(),

                    SizedBox(height: AppSizes.h30),

                    _buildLoginButton(),

                    SizedBox(height: AppSizes.h20),

                    _buildForgotPassword(),

                    SizedBox(height: AppSizes.h40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Container(
        width: AppSizes.w80,
        height: AppSizes.h80,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSizes.w20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'W',
              style: TextStyle(
                color: Colors.white,
                fontSize: AppSizes.w32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Positioned(
              bottom: AppSizes.w8,
              left: AppSizes.w12,
              child: Container(
                width: AppSizes.w4,
                height: AppSizes.w4,
                decoration: const BoxDecoration(
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
                decoration: const BoxDecoration(
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
          _buildInputField(
            label: 'Email Address',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: AppSizes.h24),
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
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? this.controller.obscurePassword.value : false,
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
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.black54),
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
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            this.controller.obscurePassword.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: const Color(0xFF718096),
          ),
          onPressed: () => this.controller.togglePasswordVisibility(),
        )
            : null,
      ),
    );
  }

  Widget _buildLoginButton() {
    return Obx(
      () => CustomButton(
        text: 'Login',
        onPressed: controller.isLoading ? null : controller.login,
        isLoading: controller.isLoading,
        backgroundColor: AppColors.primary,
        textColor: Colors.white,
        width: double.infinity,
        height: AppSizes.h50,
        borderRadius: AppSizes.w8,
      ),
    );
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
      onTap: () {
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
        textAlign: TextAlign.center,
      ),
    );
  }
}

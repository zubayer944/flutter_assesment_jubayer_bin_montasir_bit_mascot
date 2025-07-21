import 'package:flutter/material.dart';

class AppSizes {
  static late MediaQueryData _mediaQueryData;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _pixelRatio;
  static late double _statusBarHeight;
  static late double _textScaleFactor;
  static late double _devicePixelRatio;
  static late Orientation _orientation;

  // Initialize sizes
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _pixelRatio = _mediaQueryData.devicePixelRatio;
    _statusBarHeight = _mediaQueryData.padding.top;
    _textScaleFactor = _mediaQueryData.textScaler.scale(1.0);
    _devicePixelRatio = _mediaQueryData.devicePixelRatio;
    _orientation = _mediaQueryData.orientation;
  }

  // Screen dimensions

  static double get devicePixelRatio => _devicePixelRatio;
  static Orientation get orientation => _orientation;

  // Responsive methods (w, h, sp)
  static double w(double width) {
    return _screenWidth * (width / 375); // 375 is base design width
  }

  static double h(double height) {
    return _screenHeight * (height / 812); // 812 is base design height
  }

  static double sp(double fontSize) {
    return fontSize * _textScaleFactor;
  }

  // Width properties (w prefix)
  static double get w4 => 4.0;
  static double get w8 => 8.0;
  static double get w12 => 12.0;
  static double get w14 => 14.0;
  static double get w16 => 16.0;
  static double get w20 => 20.0;
  static double get w24 => 24.0;
  static double get w32 => 32.0;
  static double get w80 => 80.0;

  // Height properties (h prefix)
  static double get h8 => 8.0;
  static double get h12 => 12.0;
  static double get h20 => 20.0;
  static double get h24 => 24.0;
  static double get h30 => 30.0;
  static double get h40 => 40.0;
  static double get h50 => 50.0;
  static double get h60 => 60.0;
  static double get h80 => 80.0;

  // Responsive width methods
  static double getWidth(double percentage) {
    return _screenWidth * (percentage / 100);
  }

  static double getResponsiveWidth(double percentage) {
    return _screenWidth * (percentage / 100);
  }

  // Responsive height methods
  static double getHeight(double percentage) {
    return _screenHeight * (percentage / 100);
  }

  static double getResponsiveHeight(double percentage) {
    return _screenHeight * (percentage / 100);
  }

  // Responsive methods
  static double responsiveWidth(double width) {
    return _screenWidth * (width / 375); // 375 is base design width
  }

  static double responsiveHeight(double height) {
    return _screenHeight * (height / 812); // 812 is base design height
  }

  static double responsiveFontSize(double fontSize) {
    return fontSize * _textScaleFactor;
  }

  // Aspect ratio helpers
  static double get aspectRatio => _screenWidth / _screenHeight;
} 
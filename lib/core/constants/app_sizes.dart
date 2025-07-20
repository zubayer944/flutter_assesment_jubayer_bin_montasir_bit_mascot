import 'package:flutter/material.dart';

class AppSizes {
  static late MediaQueryData _mediaQueryData;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _pixelRatio;
  static late double _statusBarHeight;
  static late double _bottomBarHeight;
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
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = _mediaQueryData.textScaleFactor;
    _devicePixelRatio = _mediaQueryData.devicePixelRatio;
    _orientation = _mediaQueryData.orientation;
  }

  // Screen dimensions
  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
  static double get pixelRatio => _pixelRatio;
  static double get statusBarHeight => _statusBarHeight;
  static double get bottomBarHeight => _bottomBarHeight;
  static double get textScaleFactor => _textScaleFactor;
  static double get devicePixelRatio => _devicePixelRatio;
  static Orientation get orientation => _orientation;

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

  // Common sizes
  static double get xs => getWidth(2); // 2% of screen width
  static double get sm => getWidth(4); // 4% of screen width
  static double get md => getWidth(8); // 8% of screen width
  static double get lg => getWidth(12); // 12% of screen width
  static double get xl => getWidth(16); // 16% of screen width
  static double get xxl => getWidth(24); // 24% of screen width

  // Common heights
  static double get heightXs => getHeight(2); // 2% of screen height
  static double get heightSm => getHeight(4); // 4% of screen height
  static double get heightMd => getHeight(8); // 8% of screen height
  static double get heightLg => getHeight(12); // 12% of screen height
  static double get heightXl => getHeight(16); // 16% of screen height
  static double get heightXxl => getHeight(24); // 24% of screen height

  // Padding and margin sizes
  static double get paddingXs => 4.0;
  static double get paddingSm => 8.0;
  static double get paddingMd => 16.0;
  static double get paddingLg => 24.0;
  static double get paddingXl => 32.0;
  static double get paddingXxl => 48.0;

  // Border radius sizes
  static double get radiusXs => 4.0;
  static double get radiusSm => 8.0;
  static double get radiusMd => 12.0;
  static double get radiusLg => 16.0;
  static double get radiusXl => 24.0;
  static double get radiusXxl => 32.0;

  // Icon sizes
  static double get iconXs => 16.0;
  static double get iconSm => 20.0;
  static double get iconMd => 24.0;
  static double get iconLg => 32.0;
  static double get iconXl => 40.0;
  static double get iconXxl => 48.0;

  // Font sizes
  static double get fontSizeXs => 12.0;
  static double get fontSizeSm => 14.0;
  static double get fontSizeMd => 16.0;
  static double get fontSizeLg => 18.0;
  static double get fontSizeXl => 20.0;
  static double get fontSizeXxl => 24.0;
  static double get fontSizeH1 => 32.0;
  static double get fontSizeH2 => 28.0;
  static double get fontSizeH3 => 24.0;
  static double get fontSizeH4 => 20.0;
  static double get fontSizeH5 => 18.0;
  static double get fontSizeH6 => 16.0;

  // Button sizes
  static double get buttonHeight => 48.0;
  static double get buttonHeightSm => 36.0;
  static double get buttonHeightLg => 56.0;
  static double get buttonRadius => 8.0;

  // Input field sizes
  static double get inputHeight => 48.0;
  static double get inputRadius => 8.0;

  // Card sizes
  static double get cardRadius => 12.0;
  static double get cardElevation => 2.0;

  // App bar sizes
  static double get appBarHeight => 56.0;
  static double get appBarHeightLg => 64.0;

  // Bottom navigation sizes
  static double get bottomNavHeight => 56.0;

  // Responsive breakpoints
  static bool get isMobile => _screenWidth < 600;
  static bool get isTablet => _screenWidth >= 600 && _screenWidth < 1200;
  static bool get isDesktop => _screenWidth >= 1200;

  // Orientation helpers
  static bool get isPortrait => _orientation == Orientation.portrait;
  static bool get isLandscape => _orientation == Orientation.landscape;

  // Safe area helpers
  static double get safeAreaTop => _statusBarHeight;
  static double get safeAreaBottom => _bottomBarHeight;
  static double get safeAreaHorizontal => _mediaQueryData.padding.left + _mediaQueryData.padding.right;

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
  static bool get isSquare => aspectRatio == 1.0;
  static bool get isWide => aspectRatio > 1.0;
  static bool get isTall => aspectRatio < 1.0;

  // Device type helpers
  static bool get isSmallDevice => _screenWidth < 320;
  static bool get isMediumDevice => _screenWidth >= 320 && _screenWidth < 480;
  static bool get isLargeDevice => _screenWidth >= 480;

  // Utility methods
  static EdgeInsets getPadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: left ?? horizontal ?? all ?? 0,
      top: top ?? vertical ?? all ?? 0,
      right: right ?? horizontal ?? all ?? 0,
      bottom: bottom ?? vertical ?? all ?? 0,
    );
  }

  static BorderRadius getBorderRadius({
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? all ?? 0),
      topRight: Radius.circular(topRight ?? all ?? 0),
      bottomLeft: Radius.circular(bottomLeft ?? all ?? 0),
      bottomRight: Radius.circular(bottomRight ?? all ?? 0),
    );
  }
} 
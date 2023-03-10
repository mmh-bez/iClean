import 'package:flutter/widgets.dart';

class ScreenSizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth;
  static double screenHeight;
  static double scaledScreenWidth;
  static double scaledScreenHeight;
  static double scaledSize;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double scaledSafeAreaWidth;
  static double scaledSafeAreaHeight;
  static double scaledFontSize;

  void initSizeConig(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    scaledScreenWidth = screenWidth / 100;
    scaledScreenHeight = screenHeight / 100;
    scaledSize = scaledScreenWidth * scaledScreenHeight;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    scaledFontSize = scaledSafeAreaWidth = (screenWidth - _safeAreaHorizontal) / 100;
    scaledSafeAreaHeight = (screenHeight - _safeAreaVertical) / 100;
  }
}

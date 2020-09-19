import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenUtil {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  double getAspectHeight(double percentage, BuildContext context) {
    return screenWidth / percentage;
  }

  /// It will use to get the height of widget.
  /// height of widget will be different base on device size.
  static double getResponsiveHeightOfWidget(int height, double screenOfWidth) {
    return screenOfWidth * height / 375.0;
  }

  /// It will use to get the width of widget.
  /// width of widget will be different base on device size.
  static double getResponsiveWidthOfWidget(int width, double screenOfWidth) {
    return screenOfWidth * width / 375.0;
  }

  /// It will use to get the Pixel based on screen size.
  static double getHorizontalPixel(Size size, double value) {
    return (value * size.width) / 375;
  }
}

//Size _size;
//
//_size = MediaQuery.of(context).size;
//
//ScreenUtil.getResponsiveHeightOfWidget(34, _size.width)
//
//ScreenUtil.getResponsiveWidthOfWidget(180, _size.width)
//
//ScreenUtil.getHorizontalPixel(_size, 11)

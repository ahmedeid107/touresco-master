
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenConfig {
  static late double screenDeviceHeight;
  static late double screenDeviceWidth;

// Design Phone Dimension
  static late double _designedDeviceHeight; //844; iphone 13
  static late double _designedDeviceWidth; //390; iphone 13

  //SafeArea
  static late double topAndBottomSafe;
  static late double topSafeArea;

  static void init(
      {required bool onlyUpDownOrientation,
      required double designDeviceWidth,
      required double designDeviceHeight}) {
    if (onlyUpDownOrientation) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    _designedDeviceHeight = designDeviceHeight;
    _designedDeviceWidth = designDeviceWidth;

    final screen = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    screenDeviceHeight = screen.height;
    screenDeviceWidth = screen.width;

    final safeArea = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .padding;
    topAndBottomSafe = safeArea.bottom + safeArea.top;
    topSafeArea = safeArea.top;
  }

  static double getFontDynamic(double value) =>
      (value / _designedDeviceWidth) * screenDeviceWidth;

  static double getXByPerecentScreen(double value) => value * screenDeviceWidth;

  static double getYByPercentScreen(double value) => value * screenDeviceHeight;

  static double getRuntimeWidthByRatio(double value) =>
      (value / _designedDeviceWidth) * screenDeviceWidth;

  static double getRuntimeHeightByRatio(double value) =>
      (value / _designedDeviceHeight) * screenDeviceHeight;
}

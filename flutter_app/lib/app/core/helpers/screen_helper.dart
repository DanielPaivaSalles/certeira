import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

class ScreenHelper {
  //Valores referência resolução 1366x768
  static const topWindows = 0.0;
  static const leftWindows = 0.0;
  static const rightWindows = 1366.0;
  static const bottomWindows = 768.0;
  //Valores referência resolução 1366x768 verdadeira
  static const topWindowsVerdadeiro = -8.0;
  static const leftWindowsVerdadeiro = -8.0;
  static const rightWindowsVerdadeiro = 1374.0;
  static const bottomWindowsVerdadeiro = 736.0;

  static Future<void> maximizarWindow() async {
    if (Platform.isWindows) {
      setWindowFrame(
        Rect.fromLTRB(
          leftWindowsVerdadeiro,
          topWindowsVerdadeiro,
          rightWindowsVerdadeiro,
          bottomWindowsVerdadeiro,
        ),
      );

      setWindowMinSize(Size.infinite);
      setWindowMaxSize(Size.infinite);
    }
  }
}

import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

class KeyboardService {
  static final KeyboardService _instance = KeyboardService._internal();

  factory KeyboardService() {
    return _instance;
  }

  KeyboardService._internal();

  void handleKeyboardEvent(KeyEvent event) {
    switch (event) {
      case KeyDownEvent():
        if (event.logicalKey == LogicalKeyboardKey.f11) {
          windowManager.isFullScreen().then((isFullScreen) {
            windowManager.setFullScreen(!isFullScreen);
          });
        }
    }
  }
}

import 'package:flutter/services.dart';

class KeyboardService {
  static final KeyboardService _instance = KeyboardService._internal();
  Function? onF11Pressed;
  Function? onSpacePressed;

  factory KeyboardService({Function? onF11Pressed, Function? onSpacePressed}) {
    _instance.onF11Pressed = onF11Pressed;
    _instance.onSpacePressed = onSpacePressed;
    return _instance;
  }

  KeyboardService._internal()
      : onF11Pressed = null,
        onSpacePressed = null;

  void handleKeyboardEvent(KeyEvent event) {
    switch (event) {
      case KeyDownEvent():
        if (event.logicalKey == LogicalKeyboardKey.f11) {
          onF11Pressed?.call();
        }
        if (event.logicalKey == LogicalKeyboardKey.space) {
          onSpacePressed?.call();
        }
    }
  }
}

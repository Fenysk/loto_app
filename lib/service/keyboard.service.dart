import 'package:flutter/services.dart';

class KeyboardService {
  static final KeyboardService _instance = KeyboardService._internal();
  Function? onF11Pressed;

  factory KeyboardService({Function? onF11Pressed}) {
    _instance.onF11Pressed = onF11Pressed;
    return _instance;
  }

  KeyboardService._internal() : onF11Pressed = null;

  void handleKeyboardEvent(KeyEvent event) {
    switch (event) {
      case KeyDownEvent():
        if (event.logicalKey == LogicalKeyboardKey.f11) {
          onF11Pressed?.call();
        }
    }
  }
}

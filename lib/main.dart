import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loto_app/loto-app.dart';
import 'package:loto_app/service/keyboard.service.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: KeyboardService().handleKeyboardEvent,
      child: const MaterialApp(
        home: LotoApp(),
      ),
    );
  }
}

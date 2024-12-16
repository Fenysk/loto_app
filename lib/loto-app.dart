import 'package:flutter/material.dart';
import 'package:loto_app/widget/loto-game.widget.dart';

class LotoApp extends StatelessWidget {
  const LotoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LotoGame()),
              );
            },
            child: const Text('Nouvelle partie'),
          ),
        ),
      ),
    );
  }
}

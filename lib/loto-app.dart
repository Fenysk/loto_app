import 'package:flutter/material.dart';
import 'package:loto_app/page/card-grid-manager.page.dart';
import 'package:loto_app/page/loto-game.page.dart';

class LotoApp extends StatelessWidget {
  const LotoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildStartGameButton(context),
              const SizedBox(height: 10),
              buildGridManagerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStartGameButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LotoGamePage()),
        );
      },
      icon: const Icon(Icons.play_arrow),
      label: const Text('Nouvelle partie'),
    );
  }

  Widget buildGridManagerButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CardGridManagerPage()),
        );
      },
      icon: const Icon(Icons.grid_4x4),
      label: const Text('Gérer les grilles'),
    );
  }
}

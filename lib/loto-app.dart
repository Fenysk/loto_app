import 'dart:math';
import 'package:flutter/material.dart';

class LotoApp extends StatefulWidget {
  const LotoApp({
    super.key,
  });

  @override
  State<LotoApp> createState() => _LotoAppState();
}

class _LotoAppState extends State<LotoApp> {
  late List<int> pendingNumbers;
  List<int> fallenNumbers = [];

  @override
  void initState() {
    resetTurn();
    super.initState();
  }

  void resetTurn() {
    setState(() {
      pendingNumbers = [];

      for (int i = 1; i <= 90; i++) pendingNumbers.add(i);

      fallenNumbers.clear();
    });
  }

  void drawRandomNumberInPending() {
    if (pendingNumbers.isEmpty) return;

    final random = Random();
    final randomIndex = random.nextInt(pendingNumbers.length);
    final drawnNumber = pendingNumbers[randomIndex];

    setState(() {
      pendingNumbers.removeAt(randomIndex);
      fallenNumbers.add(drawnNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: buildLotoGrid(),
          ),
          Expanded(
            child: buildSideSection(),
          ),
        ],
      ),
    );
  }

  Center buildSideSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: drawRandomNumberInPending,
            child: const Text('Draw Number'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetTurn,
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Padding buildLotoGrid() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 90,
        itemBuilder: (context, index) {
          int number = index + 1;
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getNumberColor(number),
            ),
            child: Center(
              child: Text(number.toString()),
            ),
          );
        },
      ),
    );
  }

  Color getNumberColor(int number) => fallenNumbers.contains(number) ? Colors.blue : Colors.grey;
}

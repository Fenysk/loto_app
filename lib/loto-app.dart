import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loto_app/repository/grid.repository.dart';
import 'package:loto_app/widget/ball-number.widget.dart';

class LotoApp extends StatefulWidget {
  const LotoApp({
    super.key,
  });

  @override
  State<LotoApp> createState() => _LotoAppState();
}

class _LotoAppState extends State<LotoApp> {
  final gridRepository = GridRepositoryImpl();

  @override
  void initState() {
    resetTurn();
    super.initState();
  }

  void resetTurn() {
    setState(() {
      gridRepository.resetTurn();
    });
  }

  void drawRandomNumberInPending() {
    setState(() {
      gridRepository.drawRandomNumberInPending();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: buildLotoGrid(),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: buildSideSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSideSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLastNumbers(),
          Spacer(),
          SizedBox(height: 40),
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

  Widget buildLastNumbers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (gridRepository.fallenNumbers.length > 2)
          BallNumberWidget(
            isFalled: true,
            number: gridRepository.fallenNumbers[gridRepository.fallenNumbers.length - 3],
            radius: 30,
          ),
        const SizedBox(width: 30),
        if (gridRepository.fallenNumbers.length > 1)
          BallNumberWidget(
            isFalled: true,
            number: gridRepository.fallenNumbers[gridRepository.fallenNumbers.length - 2],
            radius: 40,
          ),
        const SizedBox(width: 30),
        if (gridRepository.fallenNumbers.isNotEmpty)
          BallNumberWidget(
            isFalled: true,
            number: gridRepository.fallenNumbers.last,
            radius: 50,
          ),
      ],
    );
  }

  Widget buildLotoGrid() {
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
          return BallNumberWidget(
            isFalled: isFalled(number),
            number: number,
          );
        },
      ),
    );
  }

  bool isFalled(int number) => gridRepository.fallenNumbers.contains(number);
}

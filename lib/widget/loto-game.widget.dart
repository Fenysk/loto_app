import 'package:flutter/material.dart';
import 'package:loto_app/repository/grid.repository.dart';
import 'package:loto_app/widget/ball-number.widget.dart';
import 'package:loto_app/widget/loto-grid.widget.dart';

class LotoGame extends StatefulWidget {
  const LotoGame({
    super.key,
  });

  @override
  State<LotoGame> createState() => _LotoGameState();
}

class _LotoGameState extends State<LotoGame> {
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
            Flexible(
              child: LotoGridWidget(),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLastNumbers(5),
        Spacer(),
        SizedBox(height: 40),
        buildActionSections(),
      ],
    );
  }

  Widget buildActionSections() {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: drawRandomNumberInPending,
          icon: const Icon(Icons.casino),
          label: const Text('Draw Number'),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: resetTurn,
          icon: const Icon(Icons.refresh),
          label: const Text('Reset'),
        ),
      ],
    );
  }

  Widget buildLastNumbers(int count) {
    assert(count >= 0 && count <= 5, 'Count must be between 0 and 5');
    final lastNumbers = gridRepository.fallenNumbers.toList().reversed.take(count).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Last Numbers:',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: lastNumbers
              .asMap()
              .entries
              .map((entry) => BallNumberWidget(
                    isFalled: true,
                    number: entry.value,
                    radius: 40 - (entry.key * 5),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

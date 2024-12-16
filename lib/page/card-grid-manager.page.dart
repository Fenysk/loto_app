import 'package:flutter/material.dart';
import 'package:loto_app/repository/card-grid.repository.dart';

class CardGridManagerPage extends StatefulWidget {
  const CardGridManagerPage({super.key});

  @override
  State<CardGridManagerPage> createState() => _CardGridManagerPageState();
}

class _CardGridManagerPageState extends State<CardGridManagerPage> {
  final cardGridRepo = CardGridRepositoryImpl();

  List<int> numbers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid manager'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildCardGrid(),
          ElevatedButton(
            onPressed: generate15RandomNumbers,
            child: const Text('Get 5 Random Numbers'),
          ),
        ],
      ),
    );
  }

  void generate15RandomNumbers() {
    setState(() {
      numbers = cardGridRepo.generate15RandomNumbers();
    });
  }

  Widget buildCardGrid() {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(10),
      child: Table(
        border: TableBorder.all(),
        children: List.generate(3, (row) {
          return TableRow(
            children: List.generate(9, (col) {
              return Container(
                height: 70,
                width: 50,
                alignment: Alignment.center,
                child: Builder(builder: (context) {
                  for (final number in numbers) {
                    final bool isInCurrentColumn = cardGridRepo.getColumnForNumber(number) == col;
                    if (isInCurrentColumn) {
                      final int currentNumberRow;
                      final int currentNumberIndex = numbers.indexOf(number);

                      switch (currentNumberIndex) {
                        case > 9:
                          currentNumberRow = 2;
                        case > 4:
                          currentNumberRow = 1;
                        default:
                          currentNumberRow = 0;
                      }

                      final bool isCurrentRow = currentNumberRow == row;

                      if (isCurrentRow) {
                        return Text(
                          '$number',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    }
                  }

                  return SizedBox.shrink();
                }),
              );
            }),
          );
        }),
      ),
    );
  }
}

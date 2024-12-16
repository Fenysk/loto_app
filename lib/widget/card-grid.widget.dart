import 'package:flutter/material.dart';
import 'package:loto_app/repository/card-grid.repository.dart';

class CardGridWidget extends StatelessWidget {
  final List<int> cardNumbers;
  final List<int> fallenNumbers;

  const CardGridWidget({
    super.key,
    required this.cardNumbers,
    this.fallenNumbers = const [],
  });

  @override
  Widget build(BuildContext context) {
    CardGridRepositoryImpl cardGridRepo = CardGridRepositoryImpl();

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
                  for (final number in cardNumbers) {
                    final bool isInCurrentColumn = cardGridRepo.getColumnForNumber(number) == col;
                    if (isInCurrentColumn) {
                      final int currentNumberRow;
                      final int currentNumberIndex = cardNumbers.indexOf(number);

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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: fallenNumbers.contains(number) ? Colors.red : Colors.black,
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

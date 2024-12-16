import 'package:flutter/material.dart';
import 'package:loto_app/repository/grid.repository.dart';
import 'package:loto_app/widget/ball-number.widget.dart';

class LotoGridWidget extends StatelessWidget {
  LotoGridWidget({super.key});

  final gridRepository = GridRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cellWidth = (constraints.maxWidth - (9 * 10)) / 10;

        return AspectRatio(
          aspectRatio: 1,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 90,
            itemBuilder: (context, index) {
              int number = index + 1;
              return BallNumberWidget(
                isFalled: isFalled(number),
                number: number,
                radius: (cellWidth / 2).toInt(),
              );
            },
          ),
        );
      },
    );
  }

  bool isFalled(int number) => gridRepository.fallenNumbers.contains(number);
}

import 'dart:math';

import 'package:flutter/material.dart';

class BallNumberWidget extends StatelessWidget {
  final int number;
  final bool isFalled;
  final int radius;

  const BallNumberWidget({
    super.key,
    required this.isFalled,
    required this.number,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFalled ? Colors.blue : Colors.grey.shade300,
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: radius * 0.8,
          ),
        ),
      ),
    );
  }
}

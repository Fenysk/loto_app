import 'package:flutter/material.dart';
import 'package:loto_app/repository/card-grid.repository.dart';
import 'package:loto_app/widget/card-grid.widget.dart';

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
          CardGridWidget(
            cardNumbers: numbers,
            fallenNumbers: [],
          ),
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
}

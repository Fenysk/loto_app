import 'dart:math';

abstract class BallGridRepository {
  void resetTurn();
  int? drawRandomNumberInPending();
}

class GridRepositoryImpl extends BallGridRepository {
  List<int> _pendingNumbers = [];
  List<int> _fallenNumbers = [];

  List<int> get pendingNumbers => _pendingNumbers;
  List<int> get fallenNumbers => _fallenNumbers;

  static final GridRepositoryImpl _instance = GridRepositoryImpl._internal();

  GridRepositoryImpl._internal();

  factory GridRepositoryImpl() {
    return _instance;
  }

  @override
  int? drawRandomNumberInPending() {
    if (pendingNumbers.isEmpty) return null;

    final random = Random();
    final randomIndex = random.nextInt(pendingNumbers.length);
    final drawnNumber = pendingNumbers[randomIndex];

    pendingNumbers.removeAt(randomIndex);
    fallenNumbers.add(drawnNumber);

    return drawnNumber;
  }

  @override
  void resetTurn() {
    _pendingNumbers = [];

    for (int i = 1; i <= 90; i++) pendingNumbers.add(i);

    fallenNumbers.clear();
  }
}

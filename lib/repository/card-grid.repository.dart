import 'dart:math';

abstract class CardGridRepository {
  List<int> generate15RandomNumbers();
  int getColumnForNumber(int number);
}

class CardGridRepositoryImpl extends CardGridRepository {
  static final CardGridRepositoryImpl _instance = CardGridRepositoryImpl._internal();
  final _random = Random();

  factory CardGridRepositoryImpl() {
    return _instance;
  }

  CardGridRepositoryImpl._internal();

  @override
  List<int> generate15RandomNumbers() {
    final List<int> pickedNumbers = [];
    final Map<int, int> columnUsageCounts = {};

    final firstRowNumbers = generate5RandomNumbersForRow();
    pickedNumbers.addAll(firstRowNumbers);
    updateColumnUsageCounts(firstRowNumbers, columnUsageCounts);

    final secondRowNumbers = generate5RandomNumbersForRow(
      existingNumbers: pickedNumbers,
      columnUsageCounts: columnUsageCounts,
    );
    pickedNumbers.addAll(secondRowNumbers);

    final thirdRowNumbers = generate5RandomNumbersForRow(
      existingNumbers: pickedNumbers,
      columnUsageCounts: columnUsageCounts,
    );
    pickedNumbers.addAll(thirdRowNumbers);

    return pickedNumbers;
  }

  @override
  int getColumnForNumber(int number) {
    if (number == 90) return 8;
    return (number) ~/ 10;
  }

  List<int> generate5RandomNumbersForRow({
    List<int>? existingNumbers,
    Map<int, int>? columnUsageCounts,
  }) {
    final selectedNumbers = <int>[];
    final usedColumns = <int>[];

    while (selectedNumbers.length < 5) {
      final candidateNumber = _random.nextInt(90) + 1;
      final column = getColumnForNumber(candidateNumber);

      final isNumberValid = isValidNumber(
        number: candidateNumber,
        column: column,
        selectedNumbers: selectedNumbers,
        usedColumns: usedColumns,
        existingNumbers: existingNumbers,
        columnUsageCounts: columnUsageCounts,
      );

      if (isNumberValid) {
        selectedNumbers.add(candidateNumber);
        usedColumns.add(column);

        if (columnUsageCounts != null) {
          columnUsageCounts[column] = (columnUsageCounts[column] ?? 0) + 1;
        }
      }
    }

    selectedNumbers.sort();
    return selectedNumbers;
  }

  bool isValidNumber({
    required int number,
    required int column,
    required List<int> selectedNumbers,
    required List<int> usedColumns,
    List<int>? existingNumbers,
    Map<int, int>? columnUsageCounts,
  }) {
    final isUnique = !selectedNumbers.contains(number);
    final isColumnUnused = !usedColumns.contains(column);
    final isNotInExisting = existingNumbers?.contains(number) != true;

    if (columnUsageCounts != null) {
      final columnUsageCount = columnUsageCounts[column] ?? 0;
      final isColumnNotOverused = columnUsageCount < 2;
      return isUnique && isColumnUnused && isNotInExisting && isColumnNotOverused;
    }

    return isUnique && isColumnUnused && isNotInExisting;
  }

  void updateColumnUsageCounts(List<int> numbers, Map<int, int> columnUsageCounts) {
    for (final number in numbers) {
      final column = getColumnForNumber(number);
      columnUsageCounts[column] = (columnUsageCounts[column] ?? 0) + 1;
    }
  }
}

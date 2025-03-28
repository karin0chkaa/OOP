import 'dart:io';
import 'dart:math';

class NumericHandler {
  static List<double>? readNumbers(String inputNumbers) {
    List<String> numberStrings = inputNumbers.trim().split(RegExp(r'\s+'));

    if (numberStrings.isEmpty || numberStrings.first.isEmpty) {
      return [];
    }

    if (numberStrings.isEmpty) {
      return [];
    }

    List<double> numbers = [];
    for (var numStr in numberStrings) {
      try {
        numbers.add(double.parse(numStr));
      } catch (e) {
        return null;
      }
    }

    return numbers;
  }

  static List<double> processNumbers(List<double> numbers) {
    if (numbers.isEmpty) {
      return [];
    }

    var minNumber = numbers.reduce(min);

    List<double> result = [];
    for (var number in numbers) {
      result.add(number * minNumber);
    }

    return result;
  }

  static printSortedNumbers(List<double> numbers,
      {void Function(String)? outputWriter}) {
    List<double> sortedNumbers = List.from(numbers)..sort();
    String output = sortedNumbers.map((number) => number.toStringAsFixed(3)).join(' ');
    (outputWriter ?? stdout.write)(output);
  }
}

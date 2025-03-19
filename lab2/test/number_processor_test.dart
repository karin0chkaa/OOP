import 'dart:io';
import 'dart:math';

import 'package:lab2/task1/number_processor.dart';
import 'package:test/test.dart';

void main() {
  group('NumericHandler.readNumber', () {
    test('Empty input', () {
      expect(NumericHandler.readNumbers(''), equals([]));
    });

    test('Correct input of numbers', () {
      expect(NumericHandler.readNumbers('12 3 45.9 -2'),
          equals([12, 3, 45.9, -2]));
    });

    test('Incorrect data entry', () {
      expect(NumericHandler.readNumbers('12 asd 45.9 -1'), isNull);
    });

    test('Data entry with extra spaces', () {
      expect(NumericHandler.readNumbers('     34 -1 34.8       9  21     '),
          equals([34, -1, 34.8, 9, 21]));
    });
  });

  group('NumericHandler.processNumbers', () {
    test('An empty list', () {
      expect(NumericHandler.processNumbers([]), equals([]));
    });

    test('Multiplying each element of the array by the minimum element', () {
      expect(NumericHandler.processNumbers([3, -2, 0.5, -1, 0]),
          equals([-6.0, 4.0, -1.0, 2.0, -0.0]));
    });

    test('There is only one element in the array', () {
      expect(NumericHandler.processNumbers([2]), equals([4.0]));
    });
  });

  group('NumericHandler.printSortedNumbers', () {
    test('Sorting and data output', () {
      final output = StringBuffer();
      void fakePrint(String message) {
        output.write(message);
      }

      NumericHandler.printSortedNumbers([2, 4, 5.0, -1.05, 543.9876524],
          outputWriter: fakePrint);
      expect(output.toString(), equals('-1.050 2.000 4.000 5.000 543.988'));
    });
  });
}

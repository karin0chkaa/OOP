import 'dart:io';
import 'package:test/test.dart';
import 'package:lab1/task2/calcbits.dart';

void main() {
  late BitCounter bitCounter;

  setUp(() {
    bitCounter = BitCounter();
  });

  test('Counting the number of bits', ()  {
    expect(bitCounter.countNumberOfBits(0), equals(0));
    expect(bitCounter.countNumberOfBits(1), equals(1));
    expect(bitCounter.countNumberOfBits(2), equals(1));
    expect(bitCounter.countNumberOfBits(3), equals(2));
    expect(bitCounter.countNumberOfBits(4), equals(1));
    expect(bitCounter.countNumberOfBits(5), equals(2));
    expect(bitCounter.countNumberOfBits(6), equals(2));
    expect(bitCounter.countNumberOfBits(7), equals(3));
    expect(bitCounter.countNumberOfBits(8), equals(1));
    expect(bitCounter.countNumberOfBits(9), equals(2));
    expect(bitCounter.countNumberOfBits(255), equals(8));
  });

  test('Checking for a negative value input', () {
    expect(()=>bitCounter.performCalculation('-1'), throwsA(isA<FormatException>()));
  });

  test('Entering a negative number outputs an error', () {
    expect(()=>bitCounter.performCalculation('-1'), throwsA(isA<FormatException>()));
  });

  test('Counting bits for maximum int value (2^63)', () {
    int maxInt = 1 << 63;
    expect(()=>bitCounter.performCalculation('${1 << 63}'), throwsA(isA<FormatException>()));
  });

  test('Entering a number and a symbol at the same time outputs an error', () {
    expect(()=>bitCounter.performCalculation('12as'), throwsA(isA<FormatException>()));
  });
}
import 'dart:io';
import 'package:test/test.dart';
import 'package:lab1/task2/calcbits.dart';

void main() {
  late BitCounter bitCounter;

  setUp(() {
    bitCounter = BitCounter();
  });

  test('Counting the number of bits', ()  {
    expect(bitCounter.countingNumberOfBits(0), equals(0));
    expect(bitCounter.countingNumberOfBits(1), equals(1));
    expect(bitCounter.countingNumberOfBits(2), equals(1));
    expect(bitCounter.countingNumberOfBits(3), equals(2));
    expect(bitCounter.countingNumberOfBits(4), equals(1));
    expect(bitCounter.countingNumberOfBits(5), equals(2));
    expect(bitCounter.countingNumberOfBits(6), equals(2));
    expect(bitCounter.countingNumberOfBits(7), equals(3));
    expect(bitCounter.countingNumberOfBits(8), equals(1));
    expect(bitCounter.countingNumberOfBits(9), equals(2));
    expect(bitCounter.countingNumberOfBits(255), equals(8));
  });

  test('Entering characters returns an error', () {
    expect(()=>bitCounter.performingTheCalculation('abc'), throwsA(isA<FormatException>()));
  });

  test('Entering a negative number outputs an error', () {
    expect(()=>bitCounter.performingTheCalculation('-1'), throwsA(isA<FormatException>()));
  });

  test('A number greater than 255 outputs an error', () {
    expect(()=>bitCounter.performingTheCalculation('256'), throwsA(isA<FormatException>()));
  });

  test('Entering a number and a symbol at the same time outputs an error', () {
    expect(()=>bitCounter.performingTheCalculation('12as'), throwsA(isA<FormatException>()));
  });
}
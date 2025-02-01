import 'dart:io';
import 'calcbits.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Ошибка: Не указано десятичное число! Необходимо использовать: calcbits.exe <byte>');
    exit(1);
  }

  String inputNumber = arguments[0];
  BitCounter bitCounter = BitCounter();
  bitCounter.performingTheCalculation(inputNumber);
}
import 'dart:io';

class BitCounter {
  int countingNumberOfBits(int number) {
    int count = 0;
    while (number != 0) {
      count += number & 1;
      number >>= 1;
    }
    return count;
  }

  void performingTheCalculation(String inputNumber) {
    if (int.tryParse(inputNumber) == null || int.parse(inputNumber) < 0 || int.parse(inputNumber) > 255) {
      print('Ошибка: введено некорректное число!');
      exit(1);
    }

    int decNumber = int.parse(inputNumber);
    int countOfBits = countingNumberOfBits(decNumber);

    print('Количество единичных битов = ${countOfBits}');
  }
}


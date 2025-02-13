import 'dart:io';

class BitCounter {
  static const String invalidMessage = 'Ошибка: введено некорректное число!';

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
      throw FormatException(BitCounter.invalidMessage);
    }

    int decNumber = int.parse(inputNumber);
    int countOfBits = countingNumberOfBits(decNumber);

    print('Количество единичных битов = ${countOfBits}');
  }
}

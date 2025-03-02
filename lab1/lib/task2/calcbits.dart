import 'dart:io';

class BitCounter {
  static const String invalidMessage = 'Error: Incorrect number entered';

  int countNumberOfBits(int number) {
    int count = 0;
    while (number != 0) {
      count += number & 1;
      number >>= 1;
    }
    return count;
  }

  void performCalculation(String inputNumber) {
    if (int.tryParse(inputNumber) == null || int.parse(inputNumber) < 0 || int.parse(inputNumber) > 255) {
      throw FormatException(BitCounter.invalidMessage);
    }

    int decNumber = int.parse(inputNumber);
    int countOfBits = countNumberOfBits(decNumber);

    print('Number of single bits = ${countOfBits}');
  }
}

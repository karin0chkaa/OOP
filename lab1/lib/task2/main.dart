import 'dart:io';
import 'calcbits.dart';

const String invalidArgumentMessage = 'Invalid argument';
const String inputText = 'Введите десятичное число от 0 до 255: ';
const String helpMessage = '''
Справка об использовании программы: 
Необходимо использовать: calcbits.exe <byte>
Программа подсчитывает количество единичных битов в байте.
При запуске без параметров командной строки программа считывает число (байт) из stdin.
Параметр "-h" показывает справку об использовании программы.
''';

void main(List<String> arguments) {
  if(arguments.isEmpty) {
    stdout.write(inputText);
    String? number = stdin.readLineSync();

    if(number == null || number.trim().isEmpty) {
      print(invalidArgumentMessage);
      exit(0);
    }

    if (int.tryParse(number) == null || int.parse(number) < 0 || int.parse(number) > 255) {
      print(invalidArgumentMessage);
      exit(0);
    }

    BitCounter bitCounter = BitCounter();
    bitCounter.performingTheCalculation(number);

  } else if (arguments[0] == '-h') {
    print(helpMessage);
    exit(0);
  } else {
    String inputNumber = arguments[0];
    BitCounter bitCounter = BitCounter();
    bitCounter.performingTheCalculation(inputNumber);
  }
}
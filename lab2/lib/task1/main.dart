import 'dart:io';
import 'number_processor.dart';

void main() {
  String inputNumber = stdin.readLineSync() ?? '';
  List<double>? numbers = NumericHandler.readNumbers(inputNumber);

  if (numbers == null) {
    print('ERROR');
    return;
  }

  List<double> processed = NumericHandler.processNumbers(numbers);
  NumericHandler.printSortedNumbers(processed);
}

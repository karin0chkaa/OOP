import 'dart:io';
import 'car.dart';
import 'car_command_processor.dart';

void main() {
  final car = Car();
  final processor = CarCommandProcessor(car);

  while (true) {
    final input = stdin.readLineSync();
    if (input == null || input.isEmpty) break;

    processor.processCommand(input.trim());
  }
}

import 'dart:io';
import 'calcbits.dart';
import 'package:args/command_runner.dart';
import 'package:args/args.dart';

const String invalidArgumentMessage = 'Invalid argument';
const String inputText = 'Enter a decimal number from 0 to 255: ';

class CountBitsCommand extends Command{
  @override
  final name = 'count';

  @override
  final description = 'Counts the number of single bits in a byte';

  CountBitsCommand() {
    argParser
      ..addOption('number', abbr: 'n', help: 'A number from 0 to 255');
  }

  @override
  void run() {
    String? number = argResults!['number'] as String?;
    if (number == null || number.trim().isEmpty) {
      stdout.write(inputText);
      number = stdin.readLineSync();
    }

    if (number == null || number.trim().isEmpty) {
      print(invalidArgumentMessage);
      exit(0);
    }

    try {
      BitCounter bitCounter = BitCounter();
      bitCounter.performCalculation(number);
    } on FormatException catch (e) {
      print(e.message);
    }
  }
}
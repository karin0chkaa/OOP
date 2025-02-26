import 'dart:io';
import 'package:args/command_runner.dart';
import 'count_bits_command.dart';
import 'calcbits.dart';

void main(List<String> arguments) {
  final runner = CommandRunner('calcbits', 'A program for counting single bits in a byte');
  runner.addCommand(CountBitsCommand());

  try {
    runner.run(arguments);
  } on UsageException catch (e) {
    print(e.message);
    print(e.usage);
  }
}


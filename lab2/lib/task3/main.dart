import 'dart:io';
import 'dart:convert';

import 'package:args/command_runner.dart';

import 'package:lab2/task3/commands/create_command.dart';
import 'package:lab2/task3/commands/translate_command.dart';

void main(List<String> arguments) async {
  stdout.encoding = utf8;

  final runner = CommandRunner('dictionary', 'A simple translation dictionary')
    ..addCommand(TranslateCommand())
    ..addCommand(CreateCommand());

  try {
    runner.run(arguments);
  } on UsageException catch (e) {
    print(e.message);
    print(e.usage);
  }
}

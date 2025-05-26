import 'dart:io';
import 'dart:convert';

import 'package:args/command_runner.dart';

import 'package:lab2/task3/commands/commands.dart';

void main(List<String> arguments) async {
  stdout.encoding = utf8;

  final runner = CommandRunner('dictionary', 'A simple translation dictionary')
    ..addCommand(TranslateDictionaryCommand())
    ..addCommand(CreateDictionaryCommand());

  try {
    runner.run(arguments);
  } on UsageException catch (e) {
    print(e.message);
    print(e.usage);
  }
}

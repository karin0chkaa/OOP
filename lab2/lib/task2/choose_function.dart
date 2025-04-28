import 'dart:io';

import 'package:args/command_runner.dart';

import 'string_utils.dart';

class ChooseFunctionCommand extends Command {
  @override
  final name = 'function';

  @override
  final description = 'Tools for working with text';

  ChooseFunctionCommand() {
    addSubcommand(FindAndReplaceCommand());
    addSubcommand(HTMLDecodeCommand());
  }
}

class FindAndReplaceCommand extends Command {
  @override
  final name = 'replace';

  @override
  final description = 'Find and replace a word in a sentence';

  FindAndReplaceCommand() {
    argParser
    ..addOption('search', abbr: 's', help: 'Text to search for', mandatory: true)
    ..addOption('replace', abbr: 'r', help: 'Replacement text', mandatory: true)
    ..addOption('input', abbr: 'i', help: 'Input string or leave empty for stdin');
  }

  @override
  void run() async{
    final utils = StringUtils();

    if (!argResults!.wasParsed('search')) {
      print('Error: --search parameter is required');
      return;
    }

    if (!argResults!.wasParsed('replace')) {
      print('Error: --replace parameter is required');
      return;
    }

    final search = argResults!['search'] as String;
    final replace = argResults!['replace'] as String;
    var input = argResults?['input'] as String ?? '';
    
    if (input.isEmpty) {
      print('Enter text to process (Ctrl+D to finish): ');
      input = stdin.readLineSync() ?? '';
      if (input.isEmpty) {
        print('Error: Input cannot be empty');
        return;
      }
    }

    final result = utils.findAndReplace(input, search, replace);
    print('Result: $result');
  }
}

class HTMLDecodeCommand extends Command {
  @override
  final name = 'html_decode';

  @override
  final description = 'Perform html entity decoding of html string';

  HTMLDecodeCommand() {
    argParser.addOption('input', abbr: 'i', help: 'Input string (or leave empty for stdin)');
  }

  @override
  void run() async {
    final utils = StringUtils();
    var input = argResults?['input'] as String ?? '';

    if (input.isEmpty) {
      print('Enter HTML string to decode (Ctrl+D to complete): ');
      input = stdin.readLineSync() ?? '';
      if (input.isEmpty) {
        print('Error: Input cannot be empty');
        return;
      }
    }

    final result = utils.htmlDecode(input);
    print('Result: $result');
  }
}
import 'dart:convert';
import 'dart:io';
import 'package:args/command_runner.dart';

class CreateCommand extends Command {
  @override
  final name = 'create';

  @override
  final description = 'Create a new dictionary file';

  CreateCommand() {
    argParser.addOption('file',
        abbr: 'f', help: 'Dictionary file to create', mandatory: true);
  }

  @override
  Future<void> run() async {
    final file = File(argResults!['file']);
    if (file.existsSync()) {
      print('Файл уже существует. Используйте команду translate вместо этого');
      exit(1);
    }

    file.writeAsStringSync('{}', encoding: utf8);
    print('Создан новый файл словаря: ${file.path}');
  }
}

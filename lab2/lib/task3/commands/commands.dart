import 'dart:convert';
import 'dart:io';
import 'package:args/command_runner.dart';
import '../mini_dictionary.dart';

class CreateDictionaryCommand extends Command {
  @override
  final name = 'create';

  @override
  final description = 'Create a new dictionary file';

  CreateDictionaryCommand() {
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

class TranslateDictionaryCommand extends Command {
  @override
  final name = 'translate';

  @override
  final description = 'Start translation';

  TranslateDictionaryCommand() {
    argParser.addOption('file',
        abbr: 'f', help: 'Dictionary file to use', mandatory: true);
  }

  @override
  Future<void> run() async {
    final dictionaryFile = File(argResults!['file']);
    final dictionary = Dictionary(dictionaryFile);

    try {
      dictionary.downloadDictionary();

      print('''Словарь загружен. Слов в словаре: ${dictionary.wordCount}
        Введите слово для перевода или "..." для выхода
        Введите «help» для получения информации о доступных командах.''');

      await startInteractiveSession(dictionary);
    } catch (e) {
      print('Ошибка: $e');
      print('Создайте новый словарь или проверьте его содержимое.');
    }
  }

  Future<void> startInteractiveSession(Dictionary dictionary) async {
    while (true) {
      stdout.write('> ');
      var word = stdin.readLineSync(encoding: utf8)?.trim();

      if (word == '...') {
        dictionary.handleExit();
        print('До свидания!');
        break;
      }

      if (word == null || word.isEmpty) {
        continue;
      }

      if (word == 'help') {
        _printHelp();
        continue;
      }

      dictionary.translateWord(word);
    }
  }

  void _printHelp() {
    print('''
    Другие доступные команды:
    <слово> - Перевод слова
    ... - Выход
    help - Справка
    ''');
  }
}

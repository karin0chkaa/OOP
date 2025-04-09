import 'dart:io';
import 'package:args/command_runner.dart';
import '../mini_dictionary.dart';

class TranslateCommand extends Command {
  @override
  final name = 'translate';

  @override
  final description = 'Start translation';

  TranslateCommand() {
    argParser.addOption('file',
        abbr: 'f', help: 'Dictionary file to use', mandatory: true);
  }

  @override
  Future<void> run() async {
    final dictionaryFile = File(argResults!['file']);
    final dictionary = Dictionary(dictionaryFile);

    try {
      await dictionary.downloadDictionary();

      print('''Словарь загружен. Слов в словаре: ${dictionary.wordCount}
        Введите слово для перевода или "..." для выхода
        Введите «help» для получения информации о доступных командах.''');

      await dictionary.startInteractiveSession();
    } catch (e) {
      print('Ошибка: $e');
      print('Создайте новый словарь или проверьте его содержимое.');
    }
  }
}

import 'dart:io';
import 'dart:convert';

class Dictionary {
  final File dictionaryFile;

  Map<String, List<String>> _originalDictionary = {};
  Map<String, String> _lowerCaseDictionary = {};
  bool _changed = false;

  Dictionary(this.dictionaryFile);

  int get wordCount => _originalDictionary.length;

  bool get changed => _changed;

  void downloadDictionary() {
    if (dictionaryFile.existsSync()) {
      try {
        var content = dictionaryFile.readAsStringSync(encoding: utf8);

        if (content.trim().isEmpty) {
          _originalDictionary = {};
          _lowerCaseDictionary = {};
          return;
        }

        final Map<String, Object?> rawDictionaryData = json.decode(content); //

        rawDictionaryData.forEach((key, value) {
          if (value is! List) {
            throw Exception(
                'Некорректный формат словаря: значение для "$key" не является списком');
          }

          final lowerKey = key.toLowerCase();
          _lowerCaseDictionary[lowerKey] = key;

          final translation = List<String>.from(value.whereType<String>());
          if (translation.length != value.length) {
            throw Exception(
                'Некорректный формат словаря: значение для "$key" не является строками');
          }

          _originalDictionary[lowerKey] = List<String>.from(value);
        });
      } catch (e) {
        throw Exception('Ошибка загрузки словаря: ${e}');
      }
    } else {
      throw Exception('Файл словаря не найден.');
    }
  }

  /*void translateWord(String word) {
    final lowerWord = word.toLowerCase();

    if (_originalDictionary.containsKey(lowerWord)) {
      final translations = _originalDictionary[lowerWord]!;
      print(translations.join(', '));
    } else {
      print(
          'Неизвестное слово "${word}". Введите перевод(ы) через запятую или пустую строку для отказа.');
      stdout.write('> ');

      var inputWord = stdin.readLineSync(encoding: utf8)?.trim(); //не Sync

      if (inputWord != null && inputWord.isNotEmpty) {
        final translations = inputWord
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

        if (translations.isNotEmpty) {
          _originalDictionary[lowerWord] = translations;
          _lowerCaseDictionary[lowerWord] = word;
          _changed = true;

          print('Слово “$word” сохранено как “${translations.join(', ')}”.');

          for (var translation in translations) {
            final lowerTranslation = translation.toLowerCase();
            _lowerCaseDictionary.putIfAbsent(
                lowerTranslation, () => translation);
            _originalDictionary
                .putIfAbsent(lowerTranslation, () => [])
                .add(word);
          }
        }
      } else {
        print('Слово "${word}" проигнорировано.');
      }
    }
  }

   */

  void translateWord(String word) {
    final lowerWord = word.toLowerCase();

    // Ищем слово в прямых переводах (original -> translations)
    if (_originalDictionary.containsKey(lowerWord)) {
      final translations = _originalDictionary[lowerWord]!;
      print(translations.join(', '));
    }
    // Ищем слово в обратных переводах (translation -> original)
    else if (_lowerCaseDictionary.containsKey(lowerWord)) {
      final originalWord = _lowerCaseDictionary[lowerWord]!;
      final translations =
          _originalDictionary[originalWord.toLowerCase()] ?? [];
      print(translations.join(', '));
    } else {
      print(
          'Неизвестное слово "$word". Введите перевод(ы) через запятую или пустую строку для отказа.');
      stdout.write('> ');
      var inputWord = stdin.readLineSync(encoding: utf8)?.trim();

      if (inputWord != null && inputWord.isNotEmpty) {
        final translations = inputWord
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

        if (translations.isNotEmpty) {
          // Сохраняем оригинальное слово и его переводы
          _originalDictionary[lowerWord] = translations;
          _lowerCaseDictionary[lowerWord] = word;
          _changed = true;

          print('Слово “$word” сохранено как “${translations.join(', ')}”.');

          // Добавляем обратные ссылки (каждый перевод → оригинальное слово)
          for (var translation in translations) {
            final lowerTranslation = translation.toLowerCase();
            _lowerCaseDictionary.putIfAbsent(
                lowerTranslation, () => translation);
            _originalDictionary
                .putIfAbsent(lowerTranslation, () => [])
                .add(word);
          }
        }
      } else {
        print('Слово "$word" проигнорировано.');
      }
    }
  }

  Future<void> startInteractiveSession() async {
    while (true) {
      stdout.write('> ');
      var word = stdin.readLineSync(encoding: utf8)?.trim();

      if (word == '...') {
        _handleExit();
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

      translateWord(word);
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

  void _handleExit() {
    if (!_changed) {
      return;
    }

    print(
        'В словарь были внесены изменения. Введите Y или y для сохранения перед выходом.');
    final answer = stdin.readLineSync(encoding: utf8)?.trim();

    if (answer == 'Y' || answer == 'y') {
      saveChanges();
    }
  }

  void saveChanges() {
    try {
      final Map<String, List<String>> toSave = {};

      for (var key in _originalDictionary.keys) {
        final original = _lowerCaseDictionary[key] ?? key;
        toSave[original] = _originalDictionary[key]!;
      }

      dictionaryFile.writeAsStringSync(json.encode(_originalDictionary));
      print('Изменения сохранены.');
      _changed = false;
    } catch (e) {
      throw Exception('Ошибка сохранения словаря: $e');
    }
  }
}

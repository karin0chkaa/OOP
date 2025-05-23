import 'dart:io';
import 'dart:convert';

class Dictionary {
  final File dictionaryFile;

  Map<String, List<String>> _originalDictionary = {};
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
          return;
        }

        final Map<String, Object?> rawDictionaryData = json.decode(content); //

        rawDictionaryData.forEach((key, value) {
          if (value is! List) {
            throw Exception(
                'Некорректный формат словаря: значение для "$key" не является списком');
          }

          final lowerKey = key.toLowerCase();

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

  void translateWord(String word) {
    final lowerWord = word.toLowerCase();

    if (_originalDictionary.containsKey(lowerWord)) {
      final translations = _originalDictionary[lowerWord]!;
      print(translations.join(', '));
    } else {
      print(
          'Неизвестное слово "${word}". Введите перевод(ы) через запятую или пустую строку для отказа.');
      stdout.write('> ');

      var inputWord = stdin.readLineSync(encoding: utf8)?.trim();

      if (inputWord != null && inputWord.isNotEmpty) {
        final translations = inputWord
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

        if (translations.isNotEmpty) {
          _originalDictionary[lowerWord] = translations;
          _changed = true;

          print('Слово “$word” сохранено как “${translations.join(', ')}”.');

          for (var translation in translations) {
            final lowerTranslation = translation.toLowerCase();
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

  void handleExit() {
    if (!_changed) {
      return;
    }

    print(
        'В словарь были внесены изменения. Введите Y или y для сохранения перед выходом.');
    final answer = stdin.readLineSync(encoding: utf8)?.trim().toLowerCase();

    if (answer == 'y') {
      _saveChanges();
    }
  }

  void _saveChanges() {
    try {
      dictionaryFile.writeAsStringSync(json.encode(_originalDictionary));
      print('Изменения сохранены.');
      _changed = false;
    } catch (e) {
      throw Exception('Ошибка сохранения словаря: $e');
    }
  }
}

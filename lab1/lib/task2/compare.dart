import 'dart:io';

class ComparerFiles {
  void checkFiles(String firstFile, String secondFile) {
    final file1 = File(firstFile);
    final file2 = File(secondFile);

    if (!file1.existsSync()) {
      throw Exception("Файл ${firstFile} не существует!");
    }
    if (!file2.existsSync()) {
      throw Exception("Файл ${secondFile} не существует!");
    }
  }

  int comparingFiles(String firstFileName, String secondFileName) {
    try {
      checkFiles(firstFileName, secondFileName);

      final line1 = File(firstFileName).readAsLinesSync();
      final line2 = File(secondFileName).readAsLinesSync();

      int minLength = line1.length < line2.length ? line1.length : line2.length;

      for (int i = 0; i < minLength; i++) {
        if (line1[i] != line2[i]){
          return i + 1;
        }
      }

      if (line1.length != line2.length) {
        return minLength + 1;
      }

      return -1;
    } catch(e) {
      rethrow;
    }
  }
}
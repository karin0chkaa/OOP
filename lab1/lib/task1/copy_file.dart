import 'dart:io';

class WorkWithFiles {
  void checkFile(File inputFileName, File outputFileName) {
    if (!inputFileName.existsSync()) {
      throw Exception("Файл ${inputFileName.path} не существует!");
    }

    if (!outputFileName.existsSync()) {
      outputFileName.create();
    }
  }

  Future<void> copyingFile(String inputFileName, String outputFileName) async {
    final inputFile = File(inputFileName);
    final outputFile = File(outputFileName);

    checkFile(inputFile, outputFile);

    await inputFile.copy(outputFileName);
  }
}

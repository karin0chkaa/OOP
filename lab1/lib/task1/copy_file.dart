import 'dart:io';

class WorkWithFiles {
  Future<void> checkFile(File inputFileName, File outputFileName) async {
    if (!inputFileName.existsSync()) {
      throw Exception("Файл ${inputFileName.path} не существует!");
    }

    if (!outputFileName.existsSync()) {
      await outputFileName.create();
    }
  }

  Future<void> copyingFile(String inputFileName, String outputFileName) async {
    File inputFile = File(inputFileName);
    File outputFile = File(outputFileName);
    checkFile(inputFile, outputFile);

    await inputFile.copy(outputFileName);

    print('Файл ${inputFile.path} успешно скопирован!');
  }
}

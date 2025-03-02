import 'dart:io';
import 'package:lab1/task1/copy_file.dart';
import 'package:test/test.dart';

void main() {
  late Directory tempDir;
  late File inputFile;
  late File outputFile;
  late WorkWithFiles fileWorker;

  setUp((){
     tempDir = Directory.systemTemp.createTempSync();
     inputFile = File('${tempDir.path}/inputFile.txt');
     outputFile = File('${tempDir.path}/outputFile.txt');
     fileWorker = WorkWithFiles();
  });

  tearDown((){
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  test('Copy an empty file', () async {
    inputFile.createSync();
    outputFile.createSync();

    await fileWorker.copyingFile(inputFile.path, outputFile.path);

    expect(outputFile.existsSync(), isTrue);
    expect(outputFile.lengthSync(), 0);
  });

  test('Copy a non-empty file', () async {
    inputFile.writeAsStringSync('Hello, world!');

    await fileWorker.copyingFile(inputFile.path, outputFile.path);

    expect(outputFile.existsSync(), isTrue);
    expect(outputFile.readAsStringSync(), equals('Hello, world!'));
  });

  test('Handle non-existent input file', () async {
    final nonExistentFile = File('${tempDir.path}/nonExistentInputFile.txt');
    outputFile.createSync();

    final fileWorker = WorkWithFiles();

    try {
      await fileWorker.copyingFile(inputFile.path,outputFile.path);
    } catch(e) {
      expect(e.toString(), contains('Файл ${inputFile.path} не существует!'));
    }
  });

  test('Copying a file with special characters', () async {
    final specialCharacters = '®✉§©☯☭?£¢&*@!%(){}[]<>#';
    inputFile.writeAsStringSync(specialCharacters);

    final fileWorker = WorkWithFiles();

    await fileWorker.copyingFile(inputFile.path, outputFile.path);

    expect(outputFile.existsSync(), isTrue);
    expect(outputFile.readAsStringSync(), equals(specialCharacters));
  });
}
import 'dart:io';
import 'package:lab1/task1/copy_file.dart';
import 'package:test/test.dart';

void main() {
 test('Copy an empty file', () async {
  final tempDir = Directory.systemTemp.createTempSync();
  final inputFile = File('${tempDir.path}/inputFile.txt');
  final outputFile = File('${tempDir.path}outputFile.txt');

  inputFile.createSync();
  outputFile.createSync();

  final fileWorker = WorkWithFiles();
  await fileWorker.copyingFile(inputFile.path, outputFile.path);

  expect(outputFile.existsSync(), isTrue);
  expect(outputFile.lengthSync(), 0);

  tempDir.deleteSync(recursive: true);
 });

 test('Copy a non-empty file', () async {
  final tempDir = Directory.systemTemp.createTempSync();
  final inputFile = File('${tempDir.path}/inputFile.txt');
  final outputFile = File('${tempDir.path}/outputFile.txt');

  inputFile.writeAsStringSync('Hello, world!');

  final fileWorker = WorkWithFiles();
  await fileWorker.copyingFile(inputFile.path, outputFile.path);

  expect(outputFile.existsSync(), isTrue);
  expect(outputFile.readAsStringSync(), equals('Hello, world!'));

  tempDir.deleteSync(recursive: true);
 });

 test('Handle non-existent input file', () async {
  final tempDir = Directory.systemTemp.createTempSync();
  final inputFile = File('${tempDir.path}/inputFile.txt');
  final outputFile = File('${tempDir.path}/outputFile.txt');

  if (inputFile.existsSync()) {
   inputFile.deleteSync();
  }

  outputFile.createSync();

  final fileWorker = WorkWithFiles();

  try {
   await fileWorker.copyingFile(inputFile.path,outputFile.path);
  } catch(e) {
   expect(e.toString(), contains('Файл ${inputFile.path} не существует!'));
  }

  tempDir.deleteSync(recursive: true);
 });

 test('Copying a file with special characters', () async {
  final tempDir = Directory.systemTemp.createTempSync();
  final inputFile = File('${tempDir.path}/inputFile.txt');
  final outputFile = File('${tempDir.path}/outputFile.txt');

  final specialCharacters = '®✉§©☯☭?£¢&*@!%(){}[]<>#';
  inputFile.writeAsStringSync(specialCharacters);

  final fileWorker = WorkWithFiles();

  await fileWorker.copyingFile(inputFile.path, outputFile.path);

  expect(outputFile.existsSync(), isTrue);
  expect(outputFile.readAsStringSync(), equals(specialCharacters));

  tempDir.deleteSync(recursive: true);
 });
}
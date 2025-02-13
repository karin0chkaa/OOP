import 'dart:io';
import 'package:lab1/task2/compare.dart';
import 'package:test/test.dart';

void main() {
  late File file1;
  late File file2;
  late Directory tempDir;
  late ComparerFiles compare;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync();
    file1 = File('${tempDir.path}/file1.txt');
    file2 = File('${tempDir.path}/file2.txt');
    compare = ComparerFiles();
  });

  tearDown(() {
    if(tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  test('Files are equal ', () async {
    file1.writeAsStringSync('Hello\nWorld!');
    file2.writeAsStringSync('Hello\nWorld!');

    expect(compare.comparingFiles(file1.path, file2.path), -1);
  });

  test('Files of different lengths', () {
    file1.writeAsStringSync('Hello\nWorld!\nThis a test text');
    file2.writeAsStringSync('Hello\nWorld!');

    expect(compare.comparingFiles(file1.path, file2.path), 3);
  });

  test('Files of different content', () {
    file1.writeAsStringSync('Hello\nAlice');
    file2.writeAsStringSync('Hello\nBob');

    expect(compare.comparingFiles(file1.path, file2.path), 2);
  });

  test('One file is empty, the other contains text', ()  {
    file1.writeAsStringSync('');
    file2.writeAsStringSync('Test text');

    expect(compare.comparingFiles(file1.path, file2.path), 1);
  });

  test('Both files are empty', () {
    file1.writeAsStringSync('');
    file2.writeAsStringSync('');

    expect(compare.comparingFiles(file1.path, file2.path), -1);
  });

  test('The file contains special characters', (){
    file1.writeAsStringSync('®✉§©☯☭?£¢&*@!%(){}[]<>#');
    file2.writeAsStringSync('®✉§©☯☭?£¢&*@!%(){}[]<>#');

    expect(compare.comparingFiles(file1.path, file2.path), -1);
    expect(compare.comparingFiles(file1.path, file2.path), -1);
  });
}
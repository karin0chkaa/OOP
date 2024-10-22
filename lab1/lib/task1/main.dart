import 'dart:io';
import 'copy_file.dart';

void main(List<String> arguments) async {
  String inputFile = arguments[0];
  String outputFile = arguments[1];

  WorkWithFiles fileWorker = WorkWithFiles();

  await fileWorker.copyingFile(inputFile, outputFile);
}

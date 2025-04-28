import 'copy_file.dart';

void main(List<String> arguments) async {
  String inputFile = arguments[0];
  String outputFile = arguments[1];

  WorkWithFiles fileWorker = WorkWithFiles();

  try {
    await fileWorker.copyingFile(inputFile, outputFile);
    print('Файл ${inputFile} успешно скопирован!');
  }
  catch(e) {
    print('Error: ${e.toString()}');
  }
}

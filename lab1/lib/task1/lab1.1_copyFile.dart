import 'dart:io';

class workWithFiles {
  File inputFile = File('inputFile.txt');

  Future<void> checkingAndCopying() async {
    if (!File('outputFile.txt').existsSync()) {
      File outputFile = await File('outputFile.txt').create();
      print('${outputFile.path} has been created');
    }
    else {
      print('Ready!');
    }
    var fileCopy = await inputFile.copy('outputFile.txt');
  }
}

void main() {
  workWithFiles file = workWithFiles();
  file.checkingAndCopying();
}
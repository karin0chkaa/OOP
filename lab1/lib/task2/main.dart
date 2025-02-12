import 'dart:io';
import 'compare.dart';

void main(List<String> arguments) {
  String firstFile = arguments[0];
  String secondFile = arguments[1];

  final comparingFiles = ComparerFiles();

  try {
    final result = comparingFiles.comparingFiles(firstFile, secondFile);

    if(result == -1){
      print('Files are equal');
    }
    else{
      print('Files are different. Line number is ${result}');
    }
  } catch(e) {
    print(e.toString());
  }
}
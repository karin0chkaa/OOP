import 'dart:io';
import 'multmatrix.dart';
import 'package:args/command_runner.dart';
import 'package:args/args.dart';

class MultMatrixCommand extends Command {
  @override
  final name = 'multiply';

  @override
  final description = 'Multiplication of two 3*3 matrices';

  MultMatrixCommand() {
    argParser
        ..addOption('file1', abbr: 'f', help: 'Path to the first matrix file')
        ..addOption('file2', abbr: 's', help: 'Path to the second matrix file');
  }

  @override
  void run() {
    String? file1 = argResults!['file1'];
    String? file2 = argResults!['file2'];

    List<List<double>>? matrix1;
    List<List<double>>? matrix2;

    if(file1 != null && file2 != null) {
      matrix1 = WorkWithMatrix.readFile(file1);
      matrix2 = WorkWithMatrix.readFile(file2);
    } else {
      print('Enter the first matrix (3x3), row by row, separated by spaces:');
      List<String> inputLines1 = _readMatrixInput();

      print('Enter the second matrix (3x3), row by row, separated by spaces:');
      List<String> inputLines2 = _readMatrixInput();

      matrix1 = WorkWithMatrix.parse(inputLines1);
      matrix2 = WorkWithMatrix.parse(inputLines2);
    }
    if(matrix1 == null) {
      print('Error parsing the first matrix from $file1 input');
      exit(1);
    }

    if(matrix2 == null) {
      print('Error parsing the second matrix from $file2 input');
      exit(1);
    }

    List<List<double>> result = WorkWithMatrix.multiplyMatrices(matrix1, matrix2);

    print('Result matrix: ');
    WorkWithMatrix.printMatrix(result);
  }

  List<String> _readMatrixInput() {
    List<String> lines = [];
    for (int i = 0; i < 3; i++) {
      String? line = stdin.readLineSync();
      if (line == null) {
        print('Error: Not enough lines entered');
        exit(1);
    }
      lines.add(line);
    }
    return lines;
  }
}


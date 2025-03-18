import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'multmatrix.dart';

class MultMatrixCommand extends Command {
  @override
  final name = 'multiply';

  @override
  final description = 'Multiplication of two 3*3 matrices';

  MultMatrixCommand() {
    argParser
      ..addOption('firstMatrixFile', abbr: 'f', help: 'Path to the first matrix file')
      ..addOption('secondMatrixFile', abbr: 's', help: 'Path to the second matrix file');
  }

  @override
  void run() {
    String? firstMatrixFile =
        argResults!['firstMatrixFile'];
    String? secondMatrixFile = argResults!['secondMatrixFile'];

    List<List<double>>? matrix1;
    List<List<double>>? matrix2;

    if (firstMatrixFile != null && secondMatrixFile != null) {
      matrix1 = WorkWithMatrix.readFile(firstMatrixFile);
      matrix2 = WorkWithMatrix.readFile(secondMatrixFile);
    } else {
      print('Enter the first matrix (3x3), row by row, separated by spaces:');
      List<String> firstInputLines = _getMatrixFromConsole();

      print('Enter the second matrix (3x3), row by row, separated by spaces:');
      List<String> secondInputLines = _getMatrixFromConsole();

      matrix1 = WorkWithMatrix.parse(firstInputLines);
      matrix2 = WorkWithMatrix.parse(secondInputLines);
    }

    if (matrix1 == null) {
      print('Error parsing the first matrix from $firstMatrixFile input');
      exit(1);
    }

    if (matrix2 == null) {
      print('Error parsing the second matrix from $secondMatrixFile input');
      exit(1);
    }

    List<List<double>> result =
        WorkWithMatrix.multiplyMatrices(matrix1, matrix2);

    print('Result matrix: ');
    WorkWithMatrix.printMatrix(result);
  }

  List<String> _getMatrixFromConsole() {
    List<String> lines = [];

    for (int i = 0; i < 3; ++i) {
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

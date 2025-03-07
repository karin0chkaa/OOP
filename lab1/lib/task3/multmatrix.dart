import 'dart:io';

class WorkWithMatrix {
  static List<List<double>>? readFile(String fileName) {
    try {
      List<String> lines = File(fileName).readAsLinesSync();
      return parse(lines);
    } catch(e) {
      print("File reading error '$fileName': ${e.toString()}");
      return null;
    }
  }

  static List<List<double>>? parse(List<String> lines) {
    if (lines.length != 3) {
      return null;
    }

    try {
      final List<List<double>> matrix = [];
      for (int i = 0; i < 3; i++) {
        List<String> parts = lines[i].trim().split(RegExp(r'\s+'));
        if(parts.length != 3) {
          return null;
        }

        List<double> row = [];
        for(String part in parts) {
          try {
            row.add(double.parse(part));
          } catch(e) {
            return null;
          }
        }
        matrix.add(row);
      }
      return matrix;
    } catch(e) {
      return null;
    }
  }

  static List<List<double>> multiplyMatrices(List<List<double>> leftMatrix, List<List<double>> rightMatrix) {
    final List<List<double>> result = [];

    for (int i = 0; i < 3; i++) {
      result.add(List.filled(3, 0.0));
    }

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        double sum = 0;
        for(int k = 0; k < 3; k++) {
          sum += leftMatrix[i][k]*rightMatrix[k][j];
        }
        result[i][j] = sum;
      }
    }
    return result;
  }

  static void printMatrix(List<List<double>> matrix) {
    for(List<double> row in matrix) {
      String formattedRow = row.map((e) => e.toStringAsFixed(3)).join(' ');
      stdout.writeln(formattedRow);
    }
  }
}
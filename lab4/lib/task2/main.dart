import 'dart:io';
import './models/shapes.dart';
import './utils/parser.dart';

void main() {
  final shapes = <IShape>[];

  print(
      'Enter shape data (e.g. rectangle 10.3 20.15 30.7 40.4 ff0000 00ff00), EOF to finish: ');

  while (true) {
    String? line = stdin.readLineSync();
    if (line == null || line.trim().isEmpty) {
      break;
    }

    IShape? shape = parseShape(line);
    if (shape != null) {
      shapes.add(shape);
    }
  }

  if (shapes.isEmpty) {
    print('No shapes provided');
    return;
  }

  final maxAreaShape = shapes.reduce((currentMaxShape, nextShape) =>
  currentMaxShape.getArea() > nextShape.getArea()
      ? currentMaxShape
      : nextShape);
  print('\nShape with maximum area: ');
  print(formatShapeDetails(maxAreaShape));

  final minPerimeterShape = shapes.reduce((currentMaxShape, nextShape) =>
  currentMaxShape.getPerimeter() < nextShape.getPerimeter()
      ? currentMaxShape
      : nextShape);
  print('\nShape with maximum perimeter: ');
  print(formatShapeDetails(minPerimeterShape));
}

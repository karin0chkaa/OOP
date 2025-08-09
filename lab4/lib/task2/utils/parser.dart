import 'dart:io';
import '../models/shapes.dart';

int parseColor(String hexColor) {
  hexColor = hexColor.replaceAll('#', '');
  if (hexColor.length == 3) {
    hexColor = hexColor.split('').map((c) => c + c).join();
  }
  hexColor = 'FF$hexColor';
  return int.parse(hexColor, radix: 16);
}

IShape? parseShape(String line) {
  final shapeParts = line.trim().split(RegExp(r'\s+'));

  if (shapeParts.isEmpty) {
    return null;
  }

  try {
    switch (shapeParts[0].toLowerCase()) {
      case 'linesegment':
        if (shapeParts.length != 6) {
          throw FormatException('Invalid linesegment format');
        }

        return CLineSegment(
          CPoint(double.parse(shapeParts[1]), double.parse(shapeParts[2])),
          CPoint(double.parse(shapeParts[3]), double.parse(shapeParts[4])),
          parseColor(shapeParts[5]),
        );

      case 'triangle':
        if (shapeParts.length != 9) {
          throw FormatException('Invalid triangle format');
        }

        return CTriangle(
          CPoint(double.parse(shapeParts[1]), double.parse(shapeParts[2])),
          CPoint(double.parse(shapeParts[3]), double.parse(shapeParts[4])),
          CPoint(double.parse(shapeParts[5]), double.parse(shapeParts[6])),
          parseColor(shapeParts[7]),
          parseColor(shapeParts[8]),
        );

      case 'rectangle':
        if (shapeParts.length != 7) {
          throw FormatException('Invalid rectangle format');
        }

        return CRectangle(
          CPoint(double.parse(shapeParts[1]), double.parse(shapeParts[2])),
          double.parse(shapeParts[3]),
          double.parse(shapeParts[4]),
          parseColor(shapeParts[5]),
          parseColor(shapeParts[6]),
        );

      case 'circle':
        if (shapeParts.length != 6) {
          throw FormatException('Invalid circle format');
        }

        return CCircle(
          CPoint(double.parse(shapeParts[1]), double.parse(shapeParts[2])),
          double.parse(shapeParts[3]),
          parseColor(shapeParts[4]),
          parseColor(shapeParts[5]),
        );

      default:
        throw FormatException('Unknown shape type: ${shapeParts[0]}');
    }
  } catch (e) {
    stderr.write('Error parsing shape: $e');
    return null;
  }
}

String formatShapeDetails(IShape shape) {
  final buffer = StringBuffer();
  buffer.writeln('Shape: ${shape.toString()}');
  buffer.writeln('Area: ${shape.getArea().toStringAsFixed(2)}');
  buffer.writeln('Perimeter: ${shape.getPerimeter().toStringAsFixed(2)}');

  final outlineColor = shape.getOutlineColor() & 0xFFFFFF;
  buffer.writeln(
    'Outline Color: #${outlineColor.toRadixString(16).padLeft(6, '0')}',
  );

  if (shape is ISolidShape) {
    final fillColor = shape.getFillColor() & 0xFFFFFF;
    buffer.writeln(
      'Fill Color: #${fillColor.toRadixString(16).padLeft(6, '0')}',
    );
  }

  return buffer.toString();
}

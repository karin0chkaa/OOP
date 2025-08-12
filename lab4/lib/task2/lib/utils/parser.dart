import 'dart:io';
import 'dart:ui';

import 'package:task2/shapes/ccircle.dart';
import 'package:task2/shapes/clinesegment.dart';
import 'package:task2/shapes/cpoint.dart';
import 'package:task2/shapes/crectangle.dart';
import 'package:task2/shapes/ctriangle.dart';

import '../shapes/ishape.dart';

Color parseColor(String hexColor) {
  hexColor = hexColor.replaceAll('#', '');
  if (hexColor.length == 3) {
    hexColor = hexColor.split('').map((c) => c + c).join();
  }
  hexColor = 'FF$hexColor';
  return Color(int.parse(hexColor, radix: 16));
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
          startPoint: CPoint(
            x: double.parse(shapeParts[1]),
            y: double.parse(shapeParts[2]),
          ),
          endPoint: CPoint(
            x: double.parse(shapeParts[3]),
            y: double.parse(shapeParts[4]),
          ),
          outlineColor: parseColor(shapeParts[5]),
        );

      case 'triangle':
        if (shapeParts.length != 9) {
          throw FormatException('Invalid triangle format');
        }

        return CTriangle(
          vertex1: CPoint(
            x: double.parse(shapeParts[1]),
            y: double.parse(shapeParts[2]),
          ),
          vertex2: CPoint(
            x: double.parse(shapeParts[3]),
            y: double.parse(shapeParts[4]),
          ),
          vertex3: CPoint(
            x: double.parse(shapeParts[5]),
            y: double.parse(shapeParts[6]),
          ),
          outlineColor: parseColor(shapeParts[7]),
          fillColor: parseColor(shapeParts[8]),
        );

      case 'rectangle':
        if (shapeParts.length != 7) {
          throw FormatException('Invalid rectangle format');
        }

        return CRectangle(
          leftTop: CPoint(
            x: double.parse(shapeParts[1]),
            y: double.parse(shapeParts[2]),
          ),
          width: double.parse(shapeParts[3]),
          height: double.parse(shapeParts[4]),
          outlineColor: parseColor(shapeParts[5]),
          fillColor: parseColor(shapeParts[6]),
        );

      case 'circle':
        if (shapeParts.length != 6) {
          throw FormatException('Invalid circle format');
        }

        return CCircle(
          center: CPoint(
            x: double.parse(shapeParts[1]),
            y: double.parse(shapeParts[2]),
          ),
          radius: double.parse(shapeParts[3]),
          outlineColor: parseColor(shapeParts[4]),
          fillColor: parseColor(shapeParts[5]),
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

  final outlineColor =
      shape.getOutlineColor().value & 0xFFFFFF; // ignore: deprecated_member_use
  buffer.writeln(
    'Outline Color: #${outlineColor.toRadixString(16).padLeft(6, '0')}',
  );

  if (shape is ISolidShape) {
    final fillColor =
        shape.getFillColor().value & 0xFFFFFF; // ignore: deprecated_member_use
    buffer.writeln(
      'Fill Color: #${fillColor.toRadixString(16).padLeft(6, '0')}',
    );
  }

  return buffer.toString();
}

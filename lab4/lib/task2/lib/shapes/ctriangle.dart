import 'dart:math';
import 'dart:ui';

import 'package:task2/canvas/icanvas.dart';
import 'package:task2/canvas/icanvas_drawable.dart';
import 'package:task2/shapes/cpoint.dart';
import 'package:task2/shapes/ishape.dart';

class CTriangle implements ISolidShape, ICanvasDrawable {
  final CPoint vertex1;
  final CPoint vertex2;
  final CPoint vertex3;
  final Color outlineColor;
  final Color fillColor;

  CTriangle({
    required this.vertex1,
    required this.vertex2,
    required this.vertex3,
    required this.outlineColor,
    required this.fillColor,
  });

  @override
  double getArea() {
    final a = vertex1.distanceTo(vertex2);
    final b = vertex2.distanceTo(vertex3);
    final c = vertex3.distanceTo(vertex1);

    final p = (a + b + c) / 2;

    return sqrt(p * (p - a) * (p - b) * (p - c));
  }

  @override
  double getPerimeter() =>
      vertex1.distanceTo(vertex2) +
      vertex2.distanceTo(vertex3) +
      vertex3.distanceTo(vertex1);

  @override
  Color getOutlineColor() => outlineColor;

  @override
  Color getFillColor() => fillColor;

  @override
  String toString() => 'Triangle with vertices: $vertex1, $vertex2, $vertex3';

  CPoint getVertex1() => vertex1;

  CPoint getVertex2() => vertex2;

  CPoint getVertex3() => vertex3;

  @override
  void draw(ICanvas canvas) {
    canvas.fillPolygon([vertex1, vertex2, vertex3], fillColor);
    canvas.drawLine(vertex1, vertex2, outlineColor);
    canvas.drawLine(vertex2, vertex3, outlineColor);
    canvas.drawLine(vertex3, vertex1, outlineColor);
  }
}

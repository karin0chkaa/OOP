import 'dart:ui';

import 'package:task2/canvas/icanvas.dart';
import 'package:task2/canvas/icanvas_drawable.dart';
import 'package:task2/shapes/cpoint.dart';
import 'package:task2/shapes/ishape.dart';

class CLineSegment implements IShape, ICanvasDrawable {
  final CPoint startPoint;
  final CPoint endPoint;
  final Color outlineColor;

  CLineSegment({
    required this.startPoint,
    required this.endPoint,
    required this.outlineColor,
  });

  @override
  double getArea() => 0.0;

  @override
  double getPerimeter() => startPoint.distanceTo(endPoint);

  @override
  Color getOutlineColor() => outlineColor;

  @override
  String toString() => 'LineSegment from $startPoint to $endPoint';

  CPoint getStartPoint() => startPoint;

  CPoint getEndPoint() => endPoint;

  @override
  void draw(ICanvas canvas) {
    canvas.drawLine(startPoint, endPoint, outlineColor);
  }
}

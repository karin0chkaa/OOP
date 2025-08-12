import 'dart:ui';

import 'package:task2/canvas/icanvas.dart';
import 'package:task2/canvas/icanvas_drawable.dart';
import 'package:task2/shapes/cpoint.dart';
import 'package:task2/shapes/ishape.dart';

class CRectangle implements ISolidShape, ICanvasDrawable {
  final CPoint leftTop;
  final double width;
  final double height;
  final Color outlineColor;
  final Color fillColor;

  CRectangle({
    required this.leftTop,
    required this.width,
    required this.height,
    required this.outlineColor,
    required this.fillColor,
  }) {
    if (width <= 0 || height <= 0) {
      throw ArgumentError('Width and height must be positive');
    }
  }

  @override
  double getArea() => width * height;

  @override
  double getPerimeter() => 2 * (width + height);

  @override
  Color getOutlineColor() => outlineColor;

  @override
  Color getFillColor() => fillColor;

  @override
  String toString() => 'Rectangle at $leftTop (width: $width, height: $height)';

  CPoint getLeftTop() => leftTop;

  CPoint getRightBottom() =>
      CPoint(x: leftTop.x + width, y: leftTop.y + height);

  double getWidth() => width;

  double getHeight() => height;

  @override
  void draw(ICanvas canvas) {
    final points = [
      leftTop,
      CPoint(x: leftTop.x + width, y: leftTop.y),
      CPoint(x: leftTop.x + width, y: leftTop.y + height),
      CPoint(x: leftTop.x, y: leftTop.y + height),
    ];
    canvas.fillPolygon(points, fillColor);
    canvas.drawLine(points[0], points[1], outlineColor);
    canvas.drawLine(points[1], points[2], outlineColor);
    canvas.drawLine(points[2], points[3], outlineColor);
    canvas.drawLine(points[3], points[0], outlineColor);
  }
}

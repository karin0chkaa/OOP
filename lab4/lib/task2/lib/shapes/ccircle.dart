import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task2/canvas/icanvas.dart';
import 'package:task2/canvas/icanvas_drawable.dart';
import 'package:task2/shapes/cpoint.dart';
import 'package:task2/shapes/ishape.dart';

class CCircle implements ISolidShape, ICanvasDrawable {
  final CPoint center;
  final double radius;
  final Color outlineColor;
  final Color fillColor;

  CCircle({
    required this.center,
    required this.radius,
    required this.outlineColor,
    required this.fillColor,
  }) {
    if (radius <= 0 || radius.isNaN) {
      throw ArgumentError('Radius must be positive and not NaN');
    }
  }

  @override
  double getArea() => pi * radius * radius;

  @override
  double getPerimeter() => 2 * pi * radius;

  @override
  Color getOutlineColor() => outlineColor;

  @override
  Color getFillColor() => fillColor;

  @override
  String toString() => 'Circle at $center with radius $radius';

  CPoint getCenter() => center;

  double getRadius() => radius;

  @override
  void draw(ICanvas canvas) {
    canvas.fillCircle(center, radius, fillColor);
    canvas.drawCircle(center, radius, outlineColor);
  }
}

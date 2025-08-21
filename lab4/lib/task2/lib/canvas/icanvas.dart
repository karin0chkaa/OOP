import 'dart:ui';

import 'package:task2/shapes/cpoint.dart';

abstract interface class ICanvas {
  void drawLine(CPoint from, CPoint to, Color lineColor);

  void fillPolygon(List<CPoint> points, Color fillColor);

  void drawCircle(CPoint center, double radius, Color lineColor);

  void fillCircle(CPoint center, double radius, Color fillColor);
}

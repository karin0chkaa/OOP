import 'dart:ui';

import 'package:task2/canvas/icanvas.dart';
import 'package:task2/shapes/cpoint.dart';

class CCanvas implements ICanvas {
  final Canvas canvas;
  final Paint _paint = Paint();

  CCanvas(this.canvas);

  @override
  void drawLine(CPoint from, CPoint to, Color lineColor) {
    _paint
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawLine(Offset(from.x, from.y), Offset(to.x, to.y), _paint);
  }

  @override
  void fillPolygon(List<CPoint> points, Color fillColor) {
    final path = Path()
      ..addPolygon(points.map((p) => Offset(p.x, p.y)).toList(), true);
    _paint
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, _paint);
  }

  @override
  void drawCircle(CPoint center, double radius, Color lineColor) {
    _paint
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(Offset(center.x, center.y), radius, _paint);
  }

  @override
  void fillCircle(CPoint center, double radius, Color fillColor) {
    _paint
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.x, center.y), radius, _paint);
  }
}

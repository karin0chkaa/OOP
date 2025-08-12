import 'dart:ui';
import 'package:task2/canvas/icanvas.dart';
import 'package:task2/shapes/cpoint.dart';

class MockCanvas implements ICanvas {
  final List<String> calls = [];

  @override
  void drawLine(CPoint from, CPoint to, Color color) {
    calls.add(
      'drawLine(from:(${from.x},${from.y}), to:(${to.x},${to.y}), color:${color.value.toRadixString(16).padLeft(8, '0')})',
    );
  }

  @override
  void fillPolygon(List<CPoint> points, Color color) {
    calls.add(
      'fillPolygon(points:[${points.map((p) => '(${p.x},${p.y})').join(',')}], color:${color.value.toRadixString(16).padLeft(8, '0')})',
    );
  }

  @override
  void drawCircle(CPoint center, double radius, Color color) {
    calls.add(
      'drawCircle(center:(${center.x},${center.y}), radius:$radius, color:${color.value.toRadixString(16).padLeft(8, '0')})',
    );
  }

  @override
  void fillCircle(CPoint center, double radius, Color color) {
    calls.add(
      'fillCircle(center:(${center.x},${center.y}), radius:$radius, color:${color.value.toRadixString(16).padLeft(8, '0')})',
    );
  }
}

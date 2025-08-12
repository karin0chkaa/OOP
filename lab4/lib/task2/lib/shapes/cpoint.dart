import 'dart:math';

class CPoint {
  final double x;
  final double y;

  CPoint({required this.x, required this.y});

  double distanceTo(CPoint targetPoint) {
    final dx = x - targetPoint.x;
    final dy = y - targetPoint.y;
    return sqrt(dx * dx + dy * dy);
  }

  @override
  String toString() => '($x, $y)';
}

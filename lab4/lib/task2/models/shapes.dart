import 'dart:math';

class CPoint {
  final double x;
  final double y;

  CPoint(this.x, this.y);

  double distanceTo(CPoint targetPoint) {
    final dx = x - targetPoint.x;
    final dy = y - targetPoint.y;
    return sqrt(dx * dx + dy * dy);
  }

  @override
  String toString() => '($x, $y)';
}

abstract class IShape {
  double getArea();

  double getPerimeter();

  int getOutlineColor();

  String toString();
}

abstract class ISolidShape implements IShape {
  int getFillColor();
}

class CLineSegment implements IShape {
  final CPoint startPoint;
  final CPoint endPoint;
  final int outlineColor;

  CLineSegment(this.startPoint, this.endPoint, this.outlineColor);

  @override
  double getArea() => 0.0;

  @override
  double getPerimeter() => startPoint.distanceTo(endPoint);

  @override
  int getOutlineColor() => outlineColor;

  @override
  String toString() => 'LineSegment from $startPoint to $endPoint';

  CPoint getStartPoint() => startPoint;

  CPoint getEndPoint() => endPoint;
}

class CTriangle implements ISolidShape {
  final CPoint vertex1;
  final CPoint vertex2;
  final CPoint vertex3;
  final int outlineColor;
  final int fillColor;

  CTriangle(this.vertex1, this.vertex2, this.vertex3, this.outlineColor,
      this.fillColor);

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
  int getOutlineColor() => outlineColor;

  @override
  int getFillColor() => fillColor;

  @override
  String toString() => 'Triangle with vertices: $vertex1, $vertex2, $vertex3';

  CPoint getVertex1() => vertex1;

  CPoint getVertex2() => vertex2;

  CPoint getVertex3() => vertex3;
}

class CRectangle implements ISolidShape {
  final CPoint leftTop;
  final double width;
  final double height;
  final int outlineColor;
  final int fillColor;

  CRectangle(this.leftTop, this.width, this.height, this.outlineColor,
      this.fillColor) {
    if (width <= 0 || height <= 0) {
      throw ArgumentError('Width and height must be positive');
    }
  }

  @override
  double getArea() => width * height;

  @override
  double getPerimeter() => 2 * (width + height);

  @override
  int getOutlineColor() => outlineColor;

  @override
  int getFillColor() => fillColor;

  @override
  String toString() => 'Rectangle at $leftTop (width: $width, height: $height)';

  CPoint getLeftTop() => leftTop;

  CPoint getRightBottom() => CPoint(leftTop.x + width, leftTop.y + height);

  double getWidth() => width;

  double getHeight() => height;
}

class CCircle implements ISolidShape {
  final CPoint center;
  final double radius;
  final int outlineColor;
  final int fillColor;

  CCircle(this.center, this.radius, this.outlineColor, this.fillColor) {
    if (radius <= 0) {
      throw ArgumentError('Radius must be positive');
    }
  }

  @override
  double getArea() => pi * radius * radius;

  @override
  double getPerimeter() => 2 * pi * radius;

  @override
  int getOutlineColor() => outlineColor;

  @override
  int getFillColor() => fillColor;

  @override
  String toString() => 'Circle at $center with radius $radius';

  CPoint getCenter() => center;

  double getRadius() => radius;
}

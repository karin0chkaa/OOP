import 'package:test/test.dart';
import 'package:lab4/task2/models/shapes.dart';
import 'dart:math';

void main() {
  group('CPoint', () {
    test('distanceTo calculates correct distance', () {
      final p1 = CPoint(0, 0);
      final p2 = CPoint(3, 4);
      expect(p1.distanceTo(p2), equals(5.0));
    });

    test('toString returns correct format', () {
      final p = CPoint(1.5, 2.5);
      expect(p.toString(), equals('(1.5, 2.5)'));
    });
  });

  group('CLineSegment', () {
    final line = CLineSegment(CPoint(0, 0), CPoint(3, 4), 0xFF0000);

    test('getArea returns 0', () {
      expect(line.getArea(), equals(0.0));
    });

    test('getPerimeter returns correct length', () {
      expect(line.getPerimeter(), equals(5.0));
    });

    test('getOutlineColor returns correct color', () {
      expect(line.getOutlineColor(), equals(0xFF0000));
    });

    test('toString returns correct format', () {
      expect(
          line.toString(), equals('LineSegment from (0.0, 0.0) to (3.0, 4.0)'));
    });
  });

  group('CTriangle', () {
    final triangle =
    CTriangle(CPoint(0, 0), CPoint(3, 0), CPoint(0, 4), 0xFF0000, 0x00FF00);

    test('getArea calculates correct value', () {
      expect(triangle.getArea(), equals(6.0));
    });

    test('getPerimeter calculates correct value', () {
      expect(triangle.getPerimeter(), equals(12.0));
    });

    test('getOutlineColor calculates correct color', () {
      expect(triangle.getOutlineColor(), equals(0xFF0000));
    });

    test('getFillColor calculates correct color', () {
      expect(triangle.getFillColor(), equals(0x00FF00));
    });

    test('Area should be zero when all points are collinear', () {
      final triangle = CTriangle(
          CPoint(0, 0), CPoint(1, 1), CPoint(2, 2), 0xFF0000, 0x00FF00);

      expect(triangle.getArea(), equals(0.0));
    });

    test('Area should be zero when two points are the same', () {
      final triangle = CTriangle(
          CPoint(0, 0), CPoint(0, 0), CPoint(1, 1), 0xFF0000, 0x00FF00);
      expect(triangle.getArea(), equals(0.0
      )
      );
    });

    test('Area should be zero when all points are the same', () {
      final triangle = CTriangle(
          CPoint(0, 0), CPoint(0, 0), CPoint(0, 0), 0xFF0000, 0x00FF00);

      expect(triangle.getArea(), equals(0.0));
    });

    test('toString returns correct format', () {
      expect(triangle.toString(),
          equals('Triangle with vertices: (0.0, 0.0), (3.0, 0.0), (0.0, 4.0)'));
    });
  });

  group('CRectangle', () {
    final rectangle = CRectangle(CPoint(0, 0), 3, 4, 0xFF0000, 0x00FF00);

    test('getArea calculates correct area', () {
      expect(rectangle.getArea(), equals(12.0));
    });

    test('getPerimeter calculates correct perimeter', () {
      expect(rectangle.getPerimeter(), equals(14.0));
    });

    test('getOutlineColor return correct color', () {
      expect(rectangle.getOutlineColor(), equals(0xFF0000));
    });

    test('getFillColor return correct color', () {
      expect(rectangle.getFillColor(), equals(0x00FF00));
    });

    test('toString returns correct format', () {
      expect(rectangle.toString(),
          equals('Rectangle at (0.0, 0.0) (width: 3.0, height: 4.0)'));
    });

    test('throws error for non-positive dimensions', () {
      expect(() => CRectangle(CPoint(0, 0), 0, 1, 0xFF0000, 0x00FF00),
          throwsA(isA<ArgumentError>()));
    });
  });

  group('CCircle', () {
    final circle = CCircle(CPoint(0, 0), 2, 0xFF0000, 0x00FF00);

    test('getArea calculates correct area', () {
      expect(circle.getArea(), closeTo(pi * 4, 0.0001));
    });

    test('getPerimeter calculates correct perimeter', () {
      expect(circle.getPerimeter(), closeTo(2 * pi * 2, 0.0001));
    });

    test('getOutlineColor return correct color', () {
      expect(circle.getOutlineColor(), equals(0xFF0000));
    });

    test('getFillColor return correct color', () {
      expect(circle.getFillColor(), equals(0x00FF00));
    });

    test('toString returns correct format', () {
      expect(circle.toString(), equals('Circle at (0.0, 0.0) with radius 2.0'));
    });

    test('throws error for non-positive radius', () {
      expect(() => CCircle(CPoint(0, 0), 0, 0xFF0000, 0x00FF00),
          throwsA(isA<ArgumentError>()));
    });
  });
}

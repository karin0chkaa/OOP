import 'dart:math';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:task2/canvas/mock_canvas.dart';
import 'package:task2/shapes/ccircle.dart';
import 'package:task2/shapes/clinesegment.dart';
import 'package:task2/shapes/cpoint.dart';
import 'package:task2/shapes/crectangle.dart';
import 'package:task2/shapes/ctriangle.dart';

void main() {
  group('CPoint', () {
    test('distanceTo calculates correct distance', () {
      final p1 = CPoint(x: 0, y: 0);
      final p2 = CPoint(x: 3, y: 4);
      expect(p1.distanceTo(p2), equals(5.0));
    });

    test('toString returns correct format', () {
      final p = CPoint(x: 1.5, y: 2.5);
      expect(p.toString(), equals('(1.5, 2.5)'));
    });

    test('distanceTo handles NaN values', () {
      final p1 = CPoint(x: 0, y: 0);
      final p2 = CPoint(x: double.nan, y: 0);
      expect(p1.distanceTo(p2).isNaN, isTrue);
    });

    test('distanceTo handles infinity values', () {
      final p1 = CPoint(x: 0, y: 0);
      final p2 = CPoint(x: double.infinity, y: 0);
      expect(p1.distanceTo(p2).isInfinite, isTrue);
    });

    test('constructor handles NaN coordinates', () {
      final point = CPoint(x: double.nan, y: 0);
      expect(point.x.isNaN, isTrue);
      expect(point.y, equals(0.0));
    });

    test('constructor handles Infinity coordinates', () {
      final point = CPoint(x: double.infinity, y: 0);
      expect(point.x.isInfinite, isTrue);
      expect(point.y, equals(0.0));
    });
  });

  group('CLineSegment', () {
    final line = CLineSegment(
      startPoint: CPoint(x: 0, y: 0),
      endPoint: CPoint(x: 3, y: 4),
      outlineColor: const Color(0xFFFF0000),
    );

    test('the area of the line is always zero', () {
      expect(line.getArea(), equals(0.0));
    });

    test('getPerimeter returns correct length', () {
      expect(line.getPerimeter(), equals(5.0));
    });

    test('getOutlineColor returns correct color', () {
      expect(line.getOutlineColor(), equals(const Color(0xFFFF0000)));
    });

    test('toString returns correct format', () {
      expect(
        line.toString(),
        equals('LineSegment from (0.0, 0.0) to (3.0, 4.0)'),
      );
    });

    test('draw calls correct canvas methods', () {
      final mockCanvas = MockCanvas();
      line.draw(mockCanvas);
      expect(
        mockCanvas.calls,
        contains('drawLine(from:(0.0,0.0), to:(3.0,4.0), color:ffff0000)'),
      );
    });

    test('getPerimeter handles NaN coordinates', () {
      final invalidLine = CLineSegment(
        startPoint: CPoint(x: 0, y: 0),
        endPoint: CPoint(x: double.nan, y: 0),
        outlineColor: const Color(0xFFFF0000),
      );
      expect(invalidLine.getPerimeter().isNaN, isTrue);
    });

    test('getPerimeter handles infinity coordinates', () {
      final invalidLine = CLineSegment(
        startPoint: CPoint(x: 0, y: 0),
        endPoint: CPoint(x: double.infinity, y: 0),
        outlineColor: const Color(0xFFFF0000),
      );
      expect(invalidLine.getPerimeter().isInfinite, isTrue);
    });

    test('constructor handles identical points', () {
      final invalidLine = CLineSegment(
        startPoint: CPoint(x: 0, y: 0),
        endPoint: CPoint(x: 0, y: 0),
        outlineColor: const Color(0xFFFF0000),
      );
      expect(invalidLine.getPerimeter(), equals(0.0));
    });

    test('draw handles NaN coordinates', () {
      final invalidLine = CLineSegment(
        startPoint: CPoint(x: 0, y: 0),
        endPoint: CPoint(x: double.nan, y: 0),
        outlineColor: const Color(0xFFFF0000),
      );
      final mockCanvas = MockCanvas();
      invalidLine.draw(mockCanvas);
      expect(
        mockCanvas.calls,
        contains('drawLine(from:(0.0,0.0), to:(NaN,0.0), color:ffff0000)'),
      );
    });
  });

  group('CTriangle', () {
    final triangle = CTriangle(
      vertex1: CPoint(x: 0, y: 0),
      vertex2: CPoint(x: 3, y: 0),
      vertex3: CPoint(x: 0, y: 4),
      outlineColor: const Color(0xFFFF0000),
      fillColor: const Color(0xFF00FF00),
    );

    test('getArea calculates correct value', () {
      expect(triangle.getArea(), equals(6.0));
    });

    test('getPerimeter calculates correct value', () {
      expect(triangle.getPerimeter(), equals(12.0));
    });

    test('getOutlineColor returns correct color', () {
      expect(triangle.getOutlineColor(), equals(const Color(0xFFFF0000)));
    });

    test('getFillColor returns correct color', () {
      expect(triangle.getFillColor(), equals(const Color(0xFF00FF00)));
    });

    test('toString returns correct format', () {
      expect(
        triangle.toString(),
        equals('Triangle with vertices: (0.0, 0.0), (3.0, 0.0), (0.0, 4.0)'),
      );
    });

    test('draw calls correct canvas methods', () {
      final mockCanvas = MockCanvas();
      triangle.draw(mockCanvas);
      expect(
        mockCanvas.calls,
        containsAll([
          'fillPolygon(points:[(0.0,0.0),(3.0,0.0),(0.0,4.0)], color:ff00ff00)',
          'drawLine(from:(0.0,0.0), to:(3.0,0.0), color:ffff0000)',
          'drawLine(from:(3.0,0.0), to:(0.0,4.0), color:ffff0000)',
          'drawLine(from:(0.0,4.0), to:(0.0,0.0), color:ffff0000)',
        ]),
      );
    });

    test('getArea returns zero for collinear points', () {
      final invalidTriangle = CTriangle(
        vertex1: CPoint(x: 0, y: 0),
        vertex2: CPoint(x: 1, y: 1),
        vertex3: CPoint(x: 2, y: 2),
        outlineColor: const Color(0xFFFF0000),
        fillColor: const Color(0xFF00FF00),
      );
      expect(invalidTriangle.getArea(), equals(0.0));
    });

    test('getArea returns zero when two points are the same', () {
      final invalidTriangle = CTriangle(
        vertex1: CPoint(x: 0, y: 0),
        vertex2: CPoint(x: 0, y: 0),
        vertex3: CPoint(x: 1, y: 1),
        outlineColor: const Color(0xFFFF0000),
        fillColor: const Color(0xFF00FF00),
      );
      expect(invalidTriangle.getArea(), equals(0.0));
    });

    test('getArea returns zero when all points are the same', () {
      final invalidTriangle = CTriangle(
        vertex1: CPoint(x: 0, y: 0),
        vertex2: CPoint(x: 0, y: 0),
        vertex3: CPoint(x: 0, y: 0),
        outlineColor: const Color(0xFFFF0000),
        fillColor: const Color(0xFF00FF00),
      );
      expect(invalidTriangle.getArea(), equals(0.0));
    });

    test('getArea handles NaN coordinates', () {
      final invalidTriangle = CTriangle(
        vertex1: CPoint(x: 0, y: 0),
        vertex2: CPoint(x: 3, y: 0),
        vertex3: CPoint(x: double.nan, y: 4),
        outlineColor: const Color(0xFFFF0000),
        fillColor: const Color(0xFF00FF00),
      );
      expect(invalidTriangle.getArea().isNaN, isTrue);
    });

    test('getPerimeter handles infinity coordinates', () {
      final invalidTriangle = CTriangle(
        vertex1: CPoint(x: 0, y: 0),
        vertex2: CPoint(x: double.infinity, y: 0),
        vertex3: CPoint(x: 0, y: 4),
        outlineColor: const Color(0xFFFF0000),
        fillColor: const Color(0xFF00FF00),
      );
      expect(invalidTriangle.getPerimeter().isInfinite, isTrue);
    });

    test('draw handles NaN coordinates', () {
      final invalidTriangle = CTriangle(
        vertex1: CPoint(x: 0, y: 0),
        vertex2: CPoint(x: 3, y: 0),
        vertex3: CPoint(x: double.nan, y: 4),
        outlineColor: const Color(0xFFFF0000),
        fillColor: const Color(0xFF00FF00),
      );
      final mockCanvas = MockCanvas();
      invalidTriangle.draw(mockCanvas);
      expect(
        mockCanvas.calls,
        containsAll([
          'fillPolygon(points:[(0.0,0.0),(3.0,0.0),(NaN,4.0)], color:ff00ff00)',
          'drawLine(from:(0.0,0.0), to:(3.0,0.0), color:ffff0000)',
          'drawLine(from:(3.0,0.0), to:(NaN,4.0), color:ffff0000)',
          'drawLine(from:(NaN,4.0), to:(0.0,0.0), color:ffff0000)',
        ]),
      );
    });
  });

  group('CRectangle', () {
    final rectangle = CRectangle(
      leftTop: CPoint(x: 0, y: 0),
      width: 3,
      height: 4,
      outlineColor: const Color(0xFFFF0000),
      fillColor: const Color(0xFF00FF00),
    );

    test('getArea calculates correct area', () {
      expect(rectangle.getArea(), equals(12.0));
    });

    test('getPerimeter calculates correct perimeter', () {
      expect(rectangle.getPerimeter(), equals(14.0));
    });

    test('getOutlineColor returns correct color', () {
      expect(rectangle.getOutlineColor(), equals(const Color(0xFFFF0000)));
    });

    test('getFillColor returns correct color', () {
      expect(rectangle.getFillColor(), equals(const Color(0xFF00FF00)));
    });

    test('toString returns correct format', () {
      expect(
        rectangle.toString(),
        equals('Rectangle at (0.0, 0.0) (width: 3.0, height: 4.0)'),
      );
    });

    test('draw calls correct canvas methods', () {
      final mockCanvas = MockCanvas();
      rectangle.draw(mockCanvas);
      expect(
        mockCanvas.calls,
        containsAll([
          'fillPolygon(points:[(0.0,0.0),(3.0,0.0),(3.0,4.0),(0.0,4.0)], color:ff00ff00)',
          'drawLine(from:(0.0,0.0), to:(3.0,0.0), color:ffff0000)',
          'drawLine(from:(3.0,0.0), to:(3.0,4.0), color:ffff0000)',
          'drawLine(from:(3.0,4.0), to:(0.0,4.0), color:ffff0000)',
          'drawLine(from:(0.0,4.0), to:(0.0,0.0), color:ffff0000)',
        ]),
      );
    });

    test('throws error for zero width', () {
      expect(
        () => CRectangle(
          leftTop: CPoint(x: 0, y: 0),
          width: 0,
          height: 1,
          outlineColor: const Color(0xFFFF0000),
          fillColor: const Color(0xFF00FF00),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws error for negative width', () {
      expect(
        () => CRectangle(
          leftTop: CPoint(x: 0, y: 0),
          width: -1,
          height: 1,
          outlineColor: const Color(0xFFFF0000),
          fillColor: const Color(0xFF00FF00),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws error for zero height', () {
      expect(
        () => CRectangle(
          leftTop: CPoint(x: 0, y: 0),
          width: 1,
          height: 0,
          outlineColor: const Color(0xFFFF0000),
          fillColor: const Color(0xFF00FF00),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws error for negative height', () {
      expect(
        () => CRectangle(
          leftTop: CPoint(x: 0, y: 0),
          width: 1,
          height: -1,
          outlineColor: const Color(0xFFFF0000),
          fillColor: const Color(0xFF00FF00),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getArea handles NaN coordinates', () {
      final invalidRectangle = CRectangle(
        leftTop: CPoint(x: double.nan, y: 0),
        width: 3,
        height: 4,
        outlineColor: const Color(0xFFFF0000),
        fillColor: const Color(0xFF00FF00),
      );
      expect(invalidRectangle.getArea(), equals(12.0));
    });

    test('draw handles NaN coordinates', () {
      final invalidRectangle = CRectangle(
        leftTop: CPoint(x: double.nan, y: 0),
        width: 3,
        height: 4,
        outlineColor: const Color(0xFFFF0000),
        fillColor: const Color(0xFF00FF00),
      );
      final mockCanvas = MockCanvas();
      invalidRectangle.draw(mockCanvas);
      expect(
        mockCanvas.calls,
        containsAll([
          'fillPolygon(points:[(NaN,0.0),(NaN,0.0),(NaN,4.0),(NaN,4.0)], color:ff00ff00)',
          'drawLine(from:(NaN,0.0), to:(NaN,0.0), color:ffff0000)',
          'drawLine(from:(NaN,0.0), to:(NaN,4.0), color:ffff0000)',
          'drawLine(from:(NaN,4.0), to:(NaN,4.0), color:ffff0000)',
          'drawLine(from:(NaN,4.0), to:(NaN,0.0), color:ffff0000)',
        ]),
      );
    });
  });

  group('CCircle', () {
    final circle = CCircle(
      center: CPoint(x: 0, y: 0),
      radius: 2,
      outlineColor: const Color(0xFFFF0000),
      fillColor: const Color(0xFF00FF00),
    );

    test('getArea calculates correct area', () {
      expect(circle.getArea(), closeTo(pi * 4, 0.0001));
    });

    test('getPerimeter calculates correct perimeter', () {
      expect(circle.getPerimeter(), closeTo(2 * pi * 2, 0.0001));
    });

    test('getOutlineColor returns correct color', () {
      expect(circle.getOutlineColor(), equals(const Color(0xFFFF0000)));
    });

    test('getFillColor returns correct color', () {
      expect(circle.getFillColor(), equals(const Color(0xFF00FF00)));
    });

    test('toString returns correct format', () {
      expect(circle.toString(), equals('Circle at (0.0, 0.0) with radius 2.0'));
    });

    test('draw calls correct canvas methods', () {
      final mockCanvas = MockCanvas();
      circle.draw(mockCanvas);
      expect(
        mockCanvas.calls,
        containsAll([
          'fillCircle(center:(0.0,0.0), radius:2.0, color:ff00ff00)',
          'drawCircle(center:(0.0,0.0), radius:2.0, color:ffff0000)',
        ]),
      );
    });

    test('throws error for zero radius', () {
      expect(
        () => CCircle(
          center: CPoint(x: 0, y: 0),
          radius: 0,
          outlineColor: const Color(0xFFFF0000),
          fillColor: const Color(0xFF00FF00),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws error for negative radius', () {
      expect(
        () => CCircle(
          center: CPoint(x: 0, y: 0),
          radius: -1,
          outlineColor: const Color(0xFFFF0000),
          fillColor: const Color(0xFF00FF00),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws error for NaN radius', () {
      expect(
        () => CCircle(
          center: CPoint(x: 0, y: 0),
          radius: double.nan,
          outlineColor: const Color(0xFFFF0000),
          fillColor: const Color(0xFF00FF00),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getArea handles NaN center coordinates', () {
      final invalidCircle = CCircle(
        center: CPoint(x: double.nan, y: 0),
        radius: 2,
        outlineColor: const Color(0xFFFF0000),
        fillColor: const Color(0xFF00FF00),
      );
      expect(invalidCircle.getArea(), closeTo(pi * 4, 0.0001));
    });

    test('draw handles NaN center coordinates', () {
      final invalidCircle = CCircle(
        center: CPoint(x: double.nan, y: 0),
        radius: 2,
        outlineColor: const Color(0xFFFF0000),
        fillColor: const Color(0xFF00FF00),
      );
      final mockCanvas = MockCanvas();
      invalidCircle.draw(mockCanvas);
      expect(
        mockCanvas.calls,
        containsAll([
          'fillCircle(center:(NaN,0.0), radius:2.0, color:ff00ff00)',
          'drawCircle(center:(NaN,0.0), radius:2.0, color:ffff0000)',
        ]),
      );
    });
  });
}

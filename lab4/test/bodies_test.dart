import 'package:lab4/task1/bodies/ccompound.dart';
import 'package:lab4/task1/bodies/ccone.dart';
import 'package:lab4/task1/bodies/ccylinder.dart';
import 'package:lab4/task1/bodies/cparallelepiped.dart';
import 'package:lab4/task1/bodies/csphere.dart';
import 'package:test/test.dart';

void main() {
  group('CSphere tests', () {
    test('CSphere calculates correct volume for given radius', () {
      final radius = 2.0;
      final sphere = CSphere(1.0, radius);
      expect(sphere.getVolume(), closeTo(33.5103, 0.0001));
    });

    test('CSphere requires positive radius', () {
      expect(() => CSphere(1.0, 0.0), throwsArgumentError);
      expect(() => CSphere(1.0, -1.0), throwsArgumentError);
    });
  });

  group('CParallelepiped tests', () {
    test('CParallelepiped calculates correct volume for given dimensions', () {
      final body = CParallelepiped(1.0, 2.0, 3.0, 4.0);
      expect(body.getVolume(), 24.0);
    });

    test('CParallelepiped requires positive dimensions', () {
      expect(() => CParallelepiped(1.0, 0.0, 1.0, 1.0), throwsArgumentError);
      expect(() => CParallelepiped(1.0, -1.0, 1.0, 1.0), throwsArgumentError);
    });
  });

  group('CCone test', () {
    test('CCone calculates correct volume for given radius and height', () {
      const radius = 3.0;
      const height = 4.0;
      final cone = CCone(1.0, radius, height);
      expect(cone.getVolume(), closeTo(37.6991, 0.0001));
    });

    test('CCone requires positive radius and height', () {
      expect(() => CCone(1.0, 0.0, 1.0), throwsArgumentError);
      expect(() => CCone(1.0, -1.0, 1.0), throwsArgumentError);
      expect(() => CCone(1.0, 1.0, 0.0), throwsArgumentError);
    });
  });

  group('CCylinder  test', () {
    test('CCylinder calculates correct volume for given radius and height', () {
      const radius = 2.0;
      const height = 3.0;
      final cylinder = CCylinder(1.0, radius, height);
      expect(cylinder.getVolume(), closeTo(37.6991, 0.0001));
    });

    test('CCylinder requires positive radius and height', () {
      expect(() => CCylinder(1.0, 0.0, 1.0), throwsArgumentError);
      expect(() => CCylinder(1.0, -1.0, 1.0), throwsArgumentError);
      expect(() => CCylinder(1.0, 1.0, 0.0), throwsArgumentError);
    });
  });

  group('CCompound tests', () {
    test('Empty compound body has zero volume and mass', () {
      final compound = CCompound();
      expect(compound.getVolume(), 0.0);
      expect(compound.getMass(), 0.0);
    });

    test('Compound body correctly aggregates child bodies properties', () {
      final sphere = CSphere(2.0, 1.0);
      final cube = CParallelepiped(3.0, 1.0, 1.0, 1.0);
      final compound = CCompound();
      compound.addChildBody(sphere);
      compound.addChildBody(cube);

      expect(compound.getVolume(), closeTo(5.1888, 0.0001));
      expect(compound.getMass(), closeTo(11.3776, 0.0001));
    });

    test('Compound body prevents creating cyclic references', () {
      final compound1 = CCompound();
      final compound2 = CCompound();
      final sphere = CSphere(1.0, 1.0);
      
      expect(compound1.addChildBody(compound1), isFalse);

      compound1.addChildBody(sphere);
      compound2.addChildBody(compound1);
      expect(compound1.addChildBody(compound2), isFalse);
    });

    test('Compound body cannot contain itself directly', () {
      final compound = CCompound();
      expect(compound.addChildBody(compound), isFalse);
    });
  });
}

import 'dart:math';

import 'package:lab4/task1/bodies/csolid_body.dart';

class CCone extends CSolidBody {
  final double _radius;
  final double _height;

  CCone(double density, this._radius, this._height) : super(density) {
    if (_radius <= 0 || _height <= 0) {
      throw ArgumentError('Radius and height must be positive');
    }
  }

  double getRadius() => _radius;

  double getHeight() => _height;

  @override
  double getVolume() {
    return (1 / 3) * pi * pow(_radius, 2) * _height;
  }

  @override
  String toString() {
    return "Cone:\n"
        "Radius: ${_radius.toStringAsFixed(2)} m\n"
        "Height: ${_height.toStringAsFixed(2)} m\n"
        "${super.toString()}";
  }
}

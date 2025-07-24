import 'dart:math';
import 'package:lab4/task1/bodies/csolid_body.dart';

class CSphere extends CSolidBody {
  final double _radius;

  CSphere(double density, this._radius) : super(density) {
    if (_radius <= 0) {
      throw ArgumentError('Radius must be positive');
    }
  }

  double getRadius() => _radius;

  @override
  double getVolume() {
    return (4 / 3) * pi * pow(_radius, 3);
  }

  @override
  String toString() {
    return "Sphere: \n"
        "Radius: ${_radius.toStringAsFixed(2)} m\n"
        "${super.toString()}";
  }
}

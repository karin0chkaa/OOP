import 'package:lab4/task1/bodies/csolid_body.dart';

class CParallelepiped extends CSolidBody {
  final double _width;
  final double _height;
  final double _depth;

  CParallelepiped(double density, this._width, this._height, this._depth)
    : super(density) {
    if (_width <= 0 || _height <= 0 || _depth <= 0) {
      throw ArgumentError('All dimensions must be positive');
    }
  }

  double getWidth() => _width;

  double getHeight() => _height;

  double getDepth() => _depth;

  @override
  double getVolume() {
    return _width * _height * _depth;
  }

  @override
  String toString() {
    return "Parallelepiped: \n"
        "Width: ${_width.toStringAsFixed(2)} m\n"
        "Height: ${_height.toStringAsFixed(2)} m\n"
        "Depth: ${_depth.toStringAsFixed(2)} m\n"
        "${super.toString()}";
  }
}

import 'package:lab4/task1/bodies/cbody.dart';

abstract class CSolidBody extends CBody {
  final double _density;

  CSolidBody(this._density) {
    if (_density <= 0) {
      throw ArgumentError('Density must be positive');
    }
  }

  @override
  double getDensity() => _density;

  @override
  String toString() {
    return "Density: ${getDensity().toStringAsFixed(2)} kg/m³\n"
        "Volume: ${getVolume().toStringAsFixed(2)} m³\n"
        "Mass: ${getMass().toStringAsFixed(2)} kg\n";
  }
}

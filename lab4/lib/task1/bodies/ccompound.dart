import 'package:lab4/task1/bodies/cbody.dart';

class CCompound extends CBody {
  final List<CBody> _children = [];

  @override
  double getDensity() {
    if (_children.isEmpty) return 0;
    return getMass() / getVolume();
  }

  @override
  double getVolume() {
    return _children.fold(0.0, (sum, child) => sum + child.getVolume());
  }

  @override
  double getMass() {
    return _children.fold(0.0, (sum, child) => sum + child.getMass());
  }

  bool addChildBody(CBody child) {
    if (_wouldCreateCycle(child)) {
      return false;
    }
    _children.add(child);
    return true;
  }

  bool _wouldCreateCycle(CBody newChild) {
    if (newChild == this) return true;

    if (newChild is CCompound) {
      for (var child in newChild._children) {
        if (_wouldCreateCycle(child)) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  String toString() {
    if (_children.isEmpty) {
      return "Compound body (empty)\n";
    }

    String result =
        "Compound body:\n"
        "Density: ${getDensity().toStringAsFixed(2)} kg/m³\n"
        "Volume: ${getVolume().toStringAsFixed(2)} m³\n"
        "Mass: ${getMass().toStringAsFixed(2)} kg\n"
        "Contains ${_children.length} bodies:\n";

    for (var child in _children) {
      var childStr = child.toString();
      childStr = childStr.split('\n').map((line) => '  $line').join('\n');
      result += childStr + '\n';
    }

    return result;
  }
}

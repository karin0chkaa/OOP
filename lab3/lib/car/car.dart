enum Direction { forward, standing, backward }

const _gearLimits = {
  -1: [0, 20],
  0: [0, 150],
  1: [0, 30],
  2: [20, 50],
  3: [30, 60],
  4: [40, 90],
  5: [50, 150],
};

class Car {
  bool _engineOn = false;
  int _currentGear = 0;
  int _speed = 0;
  Direction _direction = Direction.standing;

  bool get isEngineOn => _engineOn;

  int get currentGear => _engineOn ? _currentGear : 0;

  int get currentSpeed => _speed;

  String get direction => _direction.name;

  void turnOnEngine() {
    if (_engineOn) {
      throw StateError('Engine is already on');
    }

    _engineOn = true;
  }

  void turnOffEngine() {
    if (!_engineOn) {
      throw StateError('Engine is already off');
    }

    if (_currentGear != 0 || _speed != 0) {
      throw StateError('Car must be stopped and in neutral gear');
    }
    _engineOn = false;
  }

  void setGear(int gear) {
    if (gear < -1 || gear > 5) {
      throw ArgumentError('Invalid gear');
    }

    if (!_engineOn) {
      throw StateError('Cannot set gear while engine is off');
    }

    if (gear == _currentGear) return;

    _validateGearChange(gear);
    _currentGear = gear;
  }

  void setSpeed(int speed) {
    if (speed < 0) {
      throw ArgumentError('Speed cannot be negative');
    }

    if (!_engineOn) {
      throw StateError('Cannot set speed while engine is off');
    }

    if (_currentGear == 0) {
      if (speed > _speed) {
        throw StateError('Cannot accelerate on neutral');
      }

      _speed = speed;
    } else {
      final limits = _gearLimits[_currentGear]!;
      if (speed < limits[0] || speed > limits[1]) {
        throw StateError('Speed is out of gear range');
      }
      _speed = speed;
    }
    _updateDirection();
  }

  void _validateGearChange(int newGear) {
    if (newGear == -1) {
      if (_speed != 0) {
        throw StateError('Cannot reverse while moving');
      }
      return;
    }

    if (_currentGear == -1) {
      if (_speed != 0) {
        throw StateError('Cannot switch from reverse while moving');
      }
      return;
    }

    final limits = _gearLimits[newGear]!;
    if (_speed < limits[0] || _speed > limits[1]) {
      throw StateError('Unsuitable current speed');
    }
  }

  void _updateDirection() {
    if (_speed == 0) {
      _direction = Direction.standing;
    } else if (_currentGear == -1) {
      _direction = Direction.backward;
    } else {
      _direction = Direction.forward;
    }
  }
}

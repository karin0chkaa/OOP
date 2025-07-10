import 'package:lab3/car/car.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  late Car car;

  setUp(() {
    car = Car();
  });

  group('Engine', () {
    test('Initial state is off', () {
      expect(car.isEngineOn, isFalse);
      expect(car.currentGear, 0);
      expect(car.currentSpeed, 0);
      expect(car.direction, 'standing');
    });

    test('Car turn on engine', () {
      car.turnOnEngine();
      expect(car.isEngineOn, isTrue);
    });

    test('Cannot turn on already running engine', () {
      car.turnOnEngine();
      expect(() => car.turnOnEngine(), throwsStateError);
    });

    test('Can turn off engine when stopped in neutral', () {
      car.turnOnEngine();
      expect(car.currentGear, 0);
      expect(car.currentSpeed, 0);
      car.turnOffEngine();
      expect(car.isEngineOn, isFalse);
      expect(car.direction, 'standing');
    });

    test('Cannot turn off engine when moving', () {
      car.turnOnEngine();
      car.setGear(1);
      car.setSpeed(10);
      expect(() => car.turnOffEngine(), throwsStateError);
    });

    test('Cannot turn off engine when not in neutral', () {
      car.turnOnEngine();
      car.setGear(1);
      expect(() => car.turnOffEngine(), throwsStateError);
    });
  });

  group('Gear', () {
    setUp(() => car.turnOnEngine());

    test('Initial gear is neutral', () {
      expect(car.currentGear, 0);
      expect(car.currentSpeed, 0);
    });

    test('Can set valid gear', () {
      car.setGear(1);
      expect(car.currentGear, 1);
      expect(car.currentSpeed, 0);
    });

    test('Cannot set invalid gear (< -1)', () {
      expect(() => car.setGear(-2), throwsArgumentError);
    });

    test('Cannot set invalid gear (> 5)', () {
      expect(() => car.setGear(6), throwsArgumentError);
    });

    test('Cannot set gear when engine is off', () {
      car.turnOffEngine();
      expect(() => car.setGear(1), throwsStateError);
    });

    test('Can switch to reverse when stopped', () {
      car.setGear(-1);
      expect(car.currentGear, -1);
    });

    test('Cannot switch to reverse while moving', () {
      car.setGear(1);
      car.setSpeed(10);
      expect(() => car.setGear(-1), throwsStateError);
    });

    test('Cannot switch from reverse while moving', () {
      car.setGear(-1);
      car.setSpeed(5);
      expect(() => car.setGear(1), throwsStateError);
    });
  });

  group('Speed', () {
    setUp(() => car.turnOnEngine());

    test('Initial speed is 0', () {
      expect(car.currentSpeed, 0);
    });

    test('Can set valid speed', () {
      car.setGear(1);
      car.setSpeed(20);
      expect(car.currentSpeed, 20);
      expect(car.direction, 'forward');
    });

    test('Cannot set negative speed', () {
      expect(() => car.setSpeed(-1), throwsArgumentError);
    });

    test('Cannot set speed when engine is off', () {
      car.turnOffEngine();
      expect(() => car.setSpeed(10), throwsStateError);
    });

    test('Cannot accelerate in neutral', () {
      car.setGear(1);
      car.setSpeed(10);
      car.setGear(0);
      expect(() => car.setSpeed(20), throwsStateError);
    });

    test('Can decelerate in neutral', () {
      car.setGear(1);
      car.setSpeed(20);
      car.setGear(0);
      car.setSpeed(10);
      expect(car.currentSpeed, 10);
    });

    test('Cannot exceed gear speed limits', () {
      car.setGear(1);
      expect(() => car.setSpeed(40), throwsStateError);
    });
  });

  group('Direction', () {
    setUp(() => car.turnOnEngine());

    test('Initial direction is standing', () {
      expect(car.direction, 'standing');
    });

    test('Direction changes to forward when moving forward', () {
      car.setGear(1);
      car.setSpeed(10);
      expect(car.direction, 'forward');
    });

    test('Direction changes to backward when in reverse', () {
      car.setGear(-1);
      car.setSpeed(5);
      expect(car.direction, 'backward');
    });

    test('Direction changes to standing when stopped', () {
      car.setGear(1);
      car.setSpeed(10);
      car.setSpeed(0);
      expect(car.direction, 'standing');
    });
  });
}

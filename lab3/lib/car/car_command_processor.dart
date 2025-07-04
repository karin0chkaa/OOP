import 'car.dart';

class CarCommandProcessor {
  final Car car;

  CarCommandProcessor(this.car);

  void processCommand(String command) {
    try {
      if (command == 'EngineOn') {
        print(_processEngineOn());
      } else if (command == 'EngineOff') {
        print(_processEngineOff());
      } else if (command == 'Info') {
        print(_processInfo());
      } else if (command.startsWith('SetGear')) {
        print(_processSetGear(command));
      } else if (command.startsWith('SetSpeed')) {
        print(_processSetSpeed(command));
      } else {
        print('Unknown command');
      }
    } on FormatException {
      print('Invalid command argument');
    } on Exception catch (e) {
      print(e);
    }
  }

  String _processEngineOn() {
    car.turnOnEngine();
    return 'Engine turned on';
  }

  String _processEngineOff() {
    car.turnOffEngine();
    return 'Engine turned off';
  }

  String _processInfo() {
    return '''
Engine: ${car.isEngineOn ? 'on' : 'off'}
Direction: ${car.direction}
Speed: ${car.currentSpeed}
Gear: ${car.currentGear}
    ''';
  }

  String _processSetGear(String rawCommand) {
    final commandParts = rawCommand.split(' ');
    if (commandParts.length != 2) {
      throw Exception('Invalid SetGear command');
    }

    final gear = int.tryParse(commandParts[1]);
    if (gear == null) {
      throw Exception('Invalid gear value');
    }

    car.setGear(gear);
    return 'Gear set to: $gear';
  }

  String _processSetSpeed(String rawCommand) {
    final commandParts = rawCommand.split(' ');
    if (commandParts.length != 2) {
      throw Exception('Invalid SetSpeed command');
    }

    final speed = int.tryParse(commandParts[1]);
    if (speed == null) {
      throw Exception('Invalid speed value');
    }

    car.setSpeed(speed);
    return 'Speed set to: $speed';
  }
}

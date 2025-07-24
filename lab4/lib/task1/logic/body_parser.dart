import 'dart:io';
import 'package:lab4/task1/bodies/cbody.dart';
import 'package:lab4/task1/bodies/ccompound.dart';
import 'package:lab4/task1/bodies/ccone.dart';
import 'package:lab4/task1/bodies/ccylinder.dart';
import 'package:lab4/task1/bodies/cparallelepiped.dart';
import 'package:lab4/task1/bodies/csphere.dart';

enum Command {
  sphere,
  parallelepiped,
  cone,
  cylinder,
  compound,
  info,
  max,
  water,
  exit,
  unknown,
}

class BodyParser {
  final List<CBody> _bodies = [];

  void run() {
    print('Volumetric Bodies Calculator');

    while (true) {
      _printMenu();
      final input = _prompt('\nВведите команду').toLowerCase();
      final command = _parseCommand(input);

      if (command == Command.exit) {
        print('Завершение работы');
        break;
      }

      try {
        _handleCommand(command);
      } catch (e) {
        print('Ошибка: ${e.toString()}');
      }
    }
  }

  Command _parseCommand(String userInput) {
    for (final command in Command.values) {
      if (command.name == userInput) {
        return command;
      }
    }
    return Command.unknown;
  }

  void _handleCommand(Command command) {
    switch (command) {
      case Command.sphere:
        _createSphere();
        break;
      case Command.parallelepiped:
        _createParallelepiped();
        break;
      case Command.cone:
        _createCone();
        break;
      case Command.cylinder:
        _createCylinder();
        break;
      case Command.compound:
        _createCompound();
        break;
      case Command.info:
        _printAllBodies();
        break;
      case Command.max:
        _printBodyWithMaxMass();
        break;
      case Command.water:
        _printLightestInWater();
        break;
      default:
        throw ArgumentError('Неизвестная команда: $command');
    }
  }

  void _createSphere() {
    final density = _readPositiveDouble('Плотность (kg/m³)');
    final radius = _readPositiveDouble('Радиус (m)');
    _bodies.add(CSphere(density, radius));
    print('Сфера успешно создана!');
  }

  void _createParallelepiped() {
    final density = _readPositiveDouble('Плотность (kg/m³)');
    final width = _readPositiveDouble('Ширина (m)');
    final height = _readPositiveDouble('Высота (m)');
    final depth = _readPositiveDouble('Глубина (m)');
    _bodies.add(CParallelepiped(density, width, height, depth));
    print('Параллелепипед успешно создан!');
  }

  void _createCone() {
    final density = _readPositiveDouble('Плотность (kg/m³)');
    final radius = _readPositiveDouble('Радиус (m)');
    final height = _readPositiveDouble('Высота (m)');
    _bodies.add(CCone(density, radius, height));
    print('Конус успешно создан!');
  }

  void _createCylinder() {
    final density = _readPositiveDouble('Плотность (kg/m³)');
    final radius = _readPositiveDouble('Радиус (m)');
    final height = _readPositiveDouble('Высота (m)');
    _bodies.add(CCylinder(density, radius, height));
    print('Цилиндр успешно создан!');
  }

  void _createCompound() {
    if (_bodies.isEmpty) {
      throw StateError('Нет тел для создания составного объекта');
    }

    final compound = CCompound();

    print('Доступные тела: ');
    _printBodiesList();

    while (true) {
      final input = _prompt('Введите индекс тела (или "done" для завершения)');
      if (input.toLowerCase() == 'done') break;

      final index = int.tryParse(input);
      if (index == null || index < 0 || index >= _bodies.length) {
        print('Неверный индекс');
        continue;
      }

      if (!compound.addChildBody(_bodies[index])) {
        print('Ошибка: добавление сощдало бы цикл!');
      }
    }

    if (compound.getVolume() > 0) {
      _bodies.add(compound);
      print('Составное тело успешно создано!');
    }
  }

  void _printAllBodies() {
    if (_bodies.isEmpty) {
      print('Нет созданных тел');
      return;
    }

    for (final body in _bodies) {
      print(body);
    }
  }

  void _printBodyWithMaxMass() {
    if (_bodies.isEmpty) {
      print('Нет созданных тел');
      return;
    }

    final maxMassBody = _bodies.reduce(
      (a, b) => a.getMass() > b.getMass() ? a : b,
    );

    print('Тело с максимальной массой: ');
    print(maxMassBody);
  }

  void _printLightestInWater() {
    if (_bodies.isEmpty) {
      print('Нет созданных тел');
      return;
    }

    final lightestInWater = _bodies.reduce(
      (a, b) => a.getWeightInWater() < b.getWeightInWater() ? a : b,
    );

    print('Самое легкое тело в воде:');
    print(lightestInWater);
  }

  double _readPositiveDouble(String prompt) {
    while (true) {
      final value = double.tryParse(_prompt(prompt));
      if (value != null && value > 0) return value;
      print('Ошибка: введите положительное число');
    }
  }

  void _printMenu() {
    print('\nДоступные команды: ');
    print('sphere - Создать сферу');
    print('parallelepiped - Создать параллелепипед');
    print('cone - Создать конус');
    print('cylinder - Создать цилиндр');
    print('compound - Создать составное тело');
    print('info - Показать все тела');
    print('max - Тело с максимальной массой');
    print('water - Самое легкое тело в воде');
    print('exit - Выход');
  }

  String _prompt(String message) {
    stdout.write('$message: ');
    return stdin.readLineSync()?.trim() ?? '';
  }

  void _printBodiesList() {
    for (int i = 0; i < _bodies.length; i++) {
      print('$i: ${_bodies[i].toString().split('\n').first}');
    }
  }
}

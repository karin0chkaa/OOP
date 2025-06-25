import 'dart:io';
import 'tv_set.dart';
import 'command_processor.dart';

void main() {
  final tv = TVSet();
  final processor = CommandProcessor(tv);

  while (true) {
    final line = stdin.readLineSync();
    if (line == null || line.isEmpty) {
      break;
    }
    processor.processCommands([line]);
  }
}

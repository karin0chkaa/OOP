import 'dart:io';
import 'tv_set.dart';
import 'command_processor.dart';

void main() {
  final tv = TVSet();
  final processor = CommandProcessor(tv);
  final outputs = <String>[];

  while (true) {
    final line = stdin.readLineSync();
    if (line == null || line.isEmpty) {
      break;
    }
    processor.processCommands([line], outputs);
  }

  for (final output in outputs) {
    print(output);
  }
}

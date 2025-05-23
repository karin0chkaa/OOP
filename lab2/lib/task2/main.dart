import 'package:args/command_runner.dart';
import 'package:lab2/task2/choose_function.dart';

void main(List<String> arguments) {
  final runner = CommandRunner('string_utils', 'String manipulation utilities')
    ..addCommand(ChooseFunctionCommand());

  try {
    runner.run(arguments);
  } on UsageException catch (e) {
    print(e.message);
    print(e.usage);
  }
}

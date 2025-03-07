import 'package:args/command_runner.dart';
import 'multmatrix_command.dart';

void main(List<String> arguments) {
  final runner = CommandRunner('multmatrix', 'A program that performs the multiplication of two 3*3 matrices.');
  runner.addCommand(MultMatrixCommand());

  try {
    runner.run(arguments);
  } on UsageException catch(e) {
    print(e.message);
    print(e.usage);
  }
}
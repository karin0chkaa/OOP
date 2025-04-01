import 'package:lab2/task2/string_utils.dart';
import 'package:test/test.dart';

void main() {
  final utils = StringUtils();

  test('Replacement of a single occurrence', () {
    expect(utils.findAndReplace("Hello, world!", "world", "people"),
        equals("Hello, people!"));
  });

  test('Should replace multiple occurrences', () {
    expect(utils.findAndReplace("apple, orange, apple", "apple", "banana"),
        equals("banana, orange, banana"));
  });

  test('Should return original string when search is empty', () {
    expect(utils.findAndReplace("Hello, world!", "", "people"),
        equals("Hello, world!"));
  });

  test('Should return original string when search not found', () {
    expect(utils.findAndReplace("Hello, world!", "Mother", "Dad"),
        equals("Hello, world!"));
  });

  test('Should handle empty subject string', () {
    expect(utils.findAndReplace("", "Hello", "Hey"), equals(""));
  });

  test('Should replace with empty string', () {
    expect(
        utils.findAndReplace("Hello, world!", "world", ""), equals("Hello, !"));
  });

  test('Should handle overlapping search patterns', () {
    expect(utils.findAndReplace("abcdef", "abc", "z"), equals("zdef"));
  });
}

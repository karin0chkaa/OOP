import 'dart:math';

import 'package:lab2/task2/string_utils.dart';
import 'package:test/test.dart';

void main() {
  final utils = StringUtils();

  test('Should decode &quot; to "', () {
    expect(utils.htmlDecode('&quot;'), '"');
  });

  test("Should decode &apos; to '", () {
    expect(utils.htmlDecode('&apos;'), "'");
  });

  test("Should decode &lt; to <", () {
    expect(utils.htmlDecode('&lt;'), '<');
  });

  test('Should decode &gt; to >', () {
    expect(utils.htmlDecode('&gt;'), '>');
  });

  test('Should decode &amp; to &', () {
    expect(utils.htmlDecode('&amp;'), '&');
  });

  test('Should leave unknown entities unchanged', () {
    expect(utils.htmlDecode('&unknown;'), equals('&unknown;'));
  });

  test('Should handle empty string', () {
    expect(utils.htmlDecode(""), equals(""));
  });

  test('Should handle multiple same entities', () {
    expect(utils.htmlDecode("&amp;&amp;&amp;"), "&&&");
  });

  test('Should handle string without entities', () {
    expect(utils.htmlDecode("Hello World!"), equals("Hello World!"));
  });

  test('Should handle mixed content with entities', () {
    expect(
      utils.htmlDecode("Cat &lt;says&gt; &quot;Meow&quot;. M&amp;M&apos;s"),
      equals('Cat <says> "Meow". M&M\'s'),
    );
  });

  test('Should handle incomplete entity', () {
    expect(utils.htmlDecode("Hello & World"), equals("Hello & World"));
  });
}
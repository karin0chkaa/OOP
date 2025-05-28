import 'package:test/test.dart';
import 'package:lab3/TV/tv_set.dart';

void main() {
  group('TVSet', () {
    late TVSet tv;

    setUp(() {
      tv = TVSet();
    });

    test('Initial state is off and channel is 1', () {
      expect(tv.isOn, isFalse);
      expect(tv.currentChannel, equals(0));
    });

    group('turnOn', () {
      test('turns on when off', () {
        expect(tv.turnOn(), isTrue);
        expect(tv.isOn, isTrue);
        expect(tv.currentChannel, equals(1));
      });

      test('returns false when already on', () {
        tv.turnOn();
        expect(tv.turnOn(), isFalse);
        expect(tv.isOn, isTrue);
      });
    });

    group('turnOff', () {
      test('turns off when on', () {
        tv.turnOff();
        expect(tv.turnOff(), isTrue);
        expect(tv.isOn, isFalse);
        expect(tv.currentChannel, equals(0));
      });

      test('returns true when already off', () {
        expect(tv.turnOff(), isTrue);
        expect(tv.isOn, isFalse);
      });
    });

    group('selectChannel', () {
      test('select valid channel when on', () {
        tv.turnOn();
        expect(tv.selectChannel(5), isTrue);
        expect(tv.currentChannel, equals(5));
        expect(tv.selectChannel(99), isTrue);
        expect(tv.currentChannel, equals(99));
      });

      test('returns false for invalid channel when on', () {
        tv.turnOn();
        expect(tv.selectChannel(0), isFalse);
        expect(tv.currentChannel, equals(1));
        expect(tv.selectChannel(100), isFalse);
        expect(tv.currentChannel, equals(1));
      });

      test('returns false when off', () {
        expect(tv.selectChannel(5), isFalse);
        expect(tv.currentChannel, equals(0));
      });

      test('updates previous channel', () {
        tv.turnOn();
        tv.selectChannel(5);
        tv.selectChannel(10);
        expect(tv.currentChannel, equals(10));
        expect(tv.selectPreviousChannel(), isTrue);
        expect(tv.currentChannel, equals(5));
      });
    });

    group('selectPreviousChannel', () {
      test('switches to previous channel when on and previous exists', () {
        tv.turnOn();
        tv.selectChannel(5);
        tv.selectChannel(10);
        expect(tv.selectPreviousChannel(), isTrue);
        expect(tv.currentChannel, equals(5));
        expect(tv.selectPreviousChannel(), isTrue);
        expect(tv.currentChannel, equals(10));
      });

      test('returns false when no previous channel', () {
        tv.turnOn();
        expect(tv.selectPreviousChannel(), isFalse);
        expect(tv.currentChannel, equals(1));
      });

      test('returns false when off', () {
        tv.turnOn();
        tv.selectChannel(5);
        tv.turnOff();
        expect(tv.selectPreviousChannel(), isFalse);
      });
    });

    group('setChannelName', () {
      test('sets valid channel name when on', () {
        tv.turnOn();
        expect(tv.setChannelName(5, 'BBC'), isTrue);
        expect(tv.getChannelName(5), equals('BBC'));
        expect(tv.getChannelByName('BBC'), equals(5));
      });

      test('updates existing channel name', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        expect(tv.setChannelName(5, 'CNN'), isTrue);
        expect(tv.getChannelName(5), equals('CNN'));
        expect(tv.getChannelByName('BBC'), isNull);
        expect(tv.getChannelByName('CNN'), equals(5));
      });

      test('reassigns name to new channel', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        expect(tv.setChannelName(10, 'BBC'), isTrue);
        expect(tv.getChannelName(5), isNull);
        expect(tv.getChannelName(10), equals('BBC'));
        expect(tv.getChannelByName('BBC'), equals(10));
      });

      test('returns false for invalid channel', () {
        tv.turnOn();
        expect(tv.setChannelName(0, 'BBC'), isFalse);
        expect(tv.setChannelName(100, 'BBC'), isFalse);
        expect(tv.getChannelName(0), isNull);
        expect(tv.getChannelByName('BBC'), isNull);
      });

      test('returns false for empty or whitespaces name', () {
        tv.turnOn();
        expect(tv.setChannelName(5, ''), isFalse);
        expect(tv.setChannelName(5, '     '), isFalse);
        expect(tv.getChannelName(5), isNull);
      });

      test('trims and normalizes whitespace in name', () {
        tv.turnOn();
        expect(tv.setChannelName(5, '    BBC News    '), isTrue);
        expect(tv.getChannelName(5), equals('BBC News'));
        expect(tv.getChannelByName('BBC News'), equals(5));
      });

      test('returns false when off', () {
        expect(tv.setChannelName(5, 'BBC'), isFalse);
        expect(tv.getChannelName(5), isNull);
      });
    });

    group('deleteChannelName', () {
      test('delete existing channel name when on', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        expect(tv.deleteChannelName('BBC'), isTrue);
        expect(tv.getChannelName(5), isNull);
        expect(tv.getChannelByName('BBC'), isNull);
      });

      test('returns false for non-existent name', () {
        tv.turnOn();
        expect(tv.deleteChannelName('BBC'), isFalse);
      });

      test('returns false when off', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        tv.turnOff();
        expect(tv.deleteChannelName('BBC'), isFalse);
        tv.turnOn();
        expect(tv.getChannelName(5), equals('BBC'));
      });
    });

    group('selectChannelByName', () {
      test('select channel by name when on', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        expect(tv.selectChannelByName('BBC'), isTrue);
        expect(tv.currentChannel, equals(5));
      });

      test('returns false for non-existent name', () {
        tv.turnOn();
        expect(tv.selectChannelByName('BBC'), isFalse);
        expect(tv.currentChannel, equals(1));
      });

      test('returns false when off', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        tv.turnOff();
        expect(tv.selectChannelByName('BBC'), isFalse);
      });
    });

    group('getChannelName', () {
      test('returns name for valid channel when on', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        expect(tv.getChannelName(5), equals('BBC'));
      });

      test('returns null for invalid channel', () {
        tv.turnOn();
        expect(tv.getChannelName(0), isNull);
        expect(tv.getChannelName(100), isNull);
      });

      test('returns null when off', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        tv.turnOff();
        expect(tv.getChannelName(5), isNull);
      });
    });

    group('getChannelByName', () {
      test('returns channel for valid name when on', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        expect(tv.getChannelByName('BBC'), equals(5));
      });

      test('returns null for non-existent name', () {
        tv.turnOn();
        expect(tv.getChannelByName('BBC'), isNull);
      });

      test('returns null for non-existent name', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        tv.turnOff();
        expect(tv.getChannelByName('BBC'), isNull);
      });
    });

    group('info', () {
      test('returns off message when off', () {
        expect(tv.info(), equals('TV is turned off'));
      });

      test('returns channel info when on', () {
        tv.turnOn();
        expect(
          tv.info(),
          equals('TV is turned on\nChannel is: 1'),
        );
      });

      test('includes channel names in sorted order', () {
        tv.turnOn();
        tv.setChannelName(5, 'BBC');
        tv.setChannelName(2, 'CNN');
        expect(
          tv.info(),
          equals('TV is turned on\nChannel is: 1\n2 - CNN\n5 - BBC'),
        );
      });
    });
  });
}

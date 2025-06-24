import 'package:test/test.dart';
import 'package:lab3/TV/tv_set.dart';

void main() {
  late TVSet tv;

  setUp(() => tv = TVSet());

  group('Initial state', () {
    test('TV is off and no channel selected', () {
      expect(tv.isOn, isFalse);
      expect(tv.currentChannel, equals(0));
    });
  });

  group('Turning on/off behavior', () {
    test('turnOn enables TV', () {
      tv.turnOn();
      expect(tv.isOn, isTrue);
      expect(tv.currentChannel, equals(1));
    });

    test('turnOn twice throws', () {
      tv.turnOn();
      expect(() => tv.turnOn(), throwsException);
    });

    test('turnOff disables TV', () {
      tv.turnOn();
      tv.turnOff();
      expect(tv.isOn, isFalse);
      expect(tv.currentChannel, equals(0));
    });

    test('turnOff twice throws', () {
      expect(() => tv.turnOff(), throwsException);
    });
  });

  group('Channel selection logic', () {
    test('selectChannel changes channel when on and valid', () {
      tv.turnOn();
      tv.selectChannel(10);
      expect(tv.currentChannel, equals(10));
    });

    test('selectChannel with invalid number throws', () {
      tv.turnOn();
      expect(() => tv.selectChannel(0), throwsException);
      expect(() => tv.selectChannel(100), throwsException);
    });

    test('selectChannel when off throws', () {
      expect(() => tv.selectChannel(5), throwsException);
    });

    test('selectPreviousChannel switches back and forth', () {
      tv.turnOn();
      tv.selectChannel(7);
      tv.selectChannel(10);
      tv.selectPreviousChannel();
      expect(tv.currentChannel, equals(7));
      expect(() => tv.selectPreviousChannel(), throwsException);
    });

    test('selectPreviousChannel reset and works again after new switch', () {
      tv.turnOn();
      tv.selectChannel(2);
      tv.selectChannel(10);
      tv.selectPreviousChannel();
      expect(tv.currentChannel, equals(2));
      expect(() => tv.selectPreviousChannel(), throwsException);

      tv.selectChannel(7);
      tv.selectPreviousChannel();
      expect(tv.currentChannel, equals(2));
    });

    test('selectPreviousChannel with no history throws', () {
      tv.turnOn();
      expect(() => tv.selectPreviousChannel(), throwsException);
    });

    test('selectPreviousChannel when off throws', () {
      tv.turnOn();
      tv.selectChannel(3);
      tv.turnOff();
      expect(() => tv.selectPreviousChannel(), throwsException);
    });
  });

  group('Channel naming', () {
    test('set/get channel name works when valid', () {
      tv.turnOn();
      tv.setChannelName(7, 'National Geographic');
      tv.setChannelName(10, 'BBC');
      expect(tv.getChannelName(7), equals('National Geographic'));
      expect(tv.getChannelName(10), equals('BBC'));
      expect(tv.getChannelByName('National Geographic'), equals(7));
      expect(tv.getChannelByName('BBC'), equals(10));
    });

    test('setChannelName updates existing mapping', () {
      tv.turnOn();
      tv.setChannelName(10, 'CNN');
      tv.setChannelName(10, 'Discovery');
      expect(tv.getChannelName(10), equals('Discovery'));
      expect(tv.getChannelByName('CNN'), isNull);
    });

    test('reassigning a name moves it', () {
      tv.turnOn();
      tv.setChannelName(4, 'HBO');
      tv.setChannelName(7, 'HBO');
      expect(tv.getChannelName(4), isNull);
      expect(tv.getChannelName(7), equals('HBO'));
    });

    test('invalid channel number throws', () {
      tv.turnOn();
      expect(() => tv.setChannelName(0, 'Sky'), throwsException);
      expect(() => tv.setChannelName(100, 'Sky'), throwsException);
    });

    test('empty or whitespace-only name throws', () {
      tv.turnOn();
      expect(() => tv.setChannelName(5, ''), throwsException);
      expect(() => tv.setChannelName(5, '   '), throwsException);
    });

    test('name is trimmed and normalized', () {
      tv.turnOn();
      tv.setChannelName(5, '  Animal   Planet  ');
      expect(tv.getChannelName(5), equals('Animal Planet'));
    });

    test('operations when off throw', () {
      expect(() => tv.setChannelName(2, 'FOX'), throwsException);
      expect(() => tv.deleteChannelName('FOX'), throwsException);
      expect(() => tv.getChannelName(2), throwsException);
      expect(() => tv.getChannelByName('FOX'), throwsException);
      expect(() => tv.selectChannelByName('FOX'), throwsException);
    });

    test('deleteChannelName removes mapping', () {
      tv.turnOn();
      tv.setChannelName(3, 'Eurosport');
      tv.deleteChannelName('Eurosport');
      expect(tv.getChannelName(3), isNull);
      expect(tv.getChannelByName('Eurosport'), isNull);
    });

    test('deleteChannelName non-existent throws', () {
      tv.turnOn();
      expect(() => tv.deleteChannelName('TV1000'), throwsException);
    });
  });

  group('selectChannelByName behavior', () {
    test('selectChannelByName switches if exists', () {
      tv.turnOn();
      tv.setChannelName(6, 'CNN');
      tv.selectChannelByName('CNN');
      expect(tv.currentChannel, equals(6));
    });

    test('non-existent name throws', () {
      tv.turnOn();
      expect(() => tv.selectChannelByName('Comedy Central'), throwsException);
    });
  });
}

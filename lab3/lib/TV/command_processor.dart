import 'tv_set.dart';

class CommandProcessor {
  final TVSet tv;

  CommandProcessor(this.tv);

  void processCommands(List<String> commands) {
    for (final command in commands) {
      try {
        if (command == 'TurnOn') {
          print(_processTurnOn());
        } else if (command == 'TurnOff') {
          print(_processTurnOff());
        } else if (command == 'Info') {
          print(_processInfo());
        } else if (command.startsWith('SelectChannel')) {
          print(_processSelectChannel(command));
        } else if (command == 'SelectPreviousChannel') {
          print(_processSelectPreviousChannel());
        } else if (command.startsWith('SetChannelName')) {
          print(_processSetChannelName(command));
        } else if (command.startsWith('DeleteChannelName')) {
          print(_processDeleteChannelName(command));
        } else if (command.startsWith('GetChannelName')) {
          print(_processGetChannelName(command));
        } else if (command.startsWith('GetChannelByName')) {
          print(_processGetChannelByName(command));
        } else {
          print('ERROR');
        }
      } catch (e) {
        print('ERROR');
      }
    }
  }

  String _processTurnOn() {
    tv.turnOn();
    return 'TV is turned on';
  }

  String _processTurnOff() {
    tv.turnOff();
    return 'TV is turned off';
  }

  String _processInfo() {
    String message = '';
    if (!tv.isOn) {
      message = 'TV is turned off';
    } else {
      List<String> tempMessage = ['TV is turned on'];
      tempMessage.add('Channel is: ${tv.currentChannel}');

      final channelNumbers = <int>[];
      for (int i = minChannel; i <= maxChannel; i++) {
        if (tv.getChannelName(i) != null) {
          channelNumbers.add(i);
        }
      }

      channelNumbers.sort();

      for (final channel in channelNumbers) {
        final name = tv.getChannelName(channel);
        tempMessage.add('$channel - $name');
      }

      message = tempMessage.join('\n');
    }
    return message;
  }

  String _processSelectChannel(String rawCommand) {
    final commandParts = rawCommand.split(' ');
    if (commandParts.length != 2) {
      throw Exception('Invalid SelectChannel command');
    }

    final channelNumberString = commandParts[1];
    final selectedChannel = int.tryParse(channelNumberString);

    if (selectedChannel != null) {
      tv.selectChannel(selectedChannel);
      return 'Channel switched to: $selectedChannel';
    } else {
      tv.selectChannelByName(channelNumberString.trim());
      return 'Channel switched to: ${channelNumberString.trim()}';
    }
  }

  String _processSelectPreviousChannel() {
    tv.selectPreviousChannel();
    return 'Switched to previous channel';
  }

  String _processSetChannelName(String rawCommand) {
    final commandParts = rawCommand.split(' ');
    if (commandParts.length < 3) {
      throw Exception('Invalid SetChannelName command');
    }

    final channel = int.tryParse(commandParts[1]);
    if (channel == null) {
      throw Exception('Invalid channel number');
    }

    final name = commandParts.sublist(2).join(' ').trim();
    tv.setChannelName(channel, name);
    return 'Channel name set: $channel - $name';
  }

  String _processDeleteChannelName(String rawCommand) {
    final parts = rawCommand.split(' ');
    if (parts.length < 2) {
      throw Exception('Invalid DeleteChannelName command');
    }

    final name = parts.sublist(1).join(' ').trim();
    tv.deleteChannelName(name);
    return 'Channel name deleted: $name';
  }

  String _processGetChannelName(String rawCommand) {
    final parts = rawCommand.split(' ');
    if (parts.length != 2) {
      throw Exception('Invalid GetChannelName command');
    }

    final channel = int.tryParse(parts[1]);
    if (channel == null) {
      throw Exception('Invalid channel number');
    }

    final name = tv.getChannelName(channel);
    return name != null ? 'Channel $channel name: $name' : 'ERROR';
  }

  String _processGetChannelByName(String rawCommand) {
    final parts = rawCommand.split(' ');
    if (parts.length < 2) {
      throw Exception('Invalid GetChannelByName command');
    }

    final name = parts.sublist(1).join(' ').trim();
    final channel = tv.getChannelByName(name);
    return channel != null ? 'Channel for name $name: $channel' : 'ERROR';
  }
}

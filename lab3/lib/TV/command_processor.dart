import 'tv_set.dart';

class CommandProcessor {
  final TVSet tv;

  CommandProcessor(this.tv);

  void processCommands(List<String> commands, List<String> outputs) {
    for (final command in commands) {
      try {
        if (command == 'TurnOn') {
          _processTurnOn(outputs);
        } else if (command == 'TurnOff') {
          _processTurnOff(outputs);
        } else if (command == 'Info') {
          _processInfo(outputs);
        } else if (command.startsWith('SelectChannel')) {
          _processSelectChannel(command, outputs);
        } else if (command == 'SelectPreviousChannel') {
          _processSelectPreviousChannel(outputs);
        } else if (command.startsWith('SetChannelName')) {
          _processSetChannelName(command, outputs);
        } else if (command.startsWith('DeleteChannelName')) {
          _processDeleteChannelName(command, outputs);
        } else if (command.startsWith('GetChannelName')) {
          _processGetChannelName(command, outputs);
        } else if (command.startsWith('GetChannelByName')) {
          _processGetChannelByName(command, outputs);
        } else {
          outputs.add('ERROR');
        }
      } catch (e) {
        outputs.add('ERROR');
      }
    }
  }

  void _processTurnOn(List<String> outputs) {
    tv.turnOn();
    outputs.add('TV is turned on');
  }

  void _processTurnOff(List<String> outputs) {
    tv.turnOff();
    outputs.add('TV is turned off');
  }

  void _processInfo(List<String> outputs) {
    if (!tv.isOn) {
      outputs.add('TV is turned off');
      return;
    }

    outputs.add('TV is turned on');
    outputs.add('Channel is: ${tv.currentChannel}');

    final channelNumbers = <int>[];
    for (int i = minChannel; i <= maxChannel; i++) {
      if (tv.getChannelName(i) != null) {
        channelNumbers.add(i);
      }
    }
    channelNumbers.sort();

    for (final channel in channelNumbers) {
      final name = tv.getChannelName(channel);
      outputs.add('$channel - $name');
    }
  }

  void _processSelectChannel(String rawCommand, List<String> outputs) {
    final commandParts = rawCommand.split(' ');
    if (commandParts.length != 2) {
      throw Exception('Invalid SelectChannel command');
    }

    final channelNumberString = commandParts[1];
    final selectedChannel = int.tryParse(channelNumberString);

    if (selectedChannel != null) {
      tv.selectChannel(selectedChannel);
      outputs.add('Channel switched to: $selectedChannel');
    } else {
      tv.selectChannelByName(channelNumberString.trim());
      outputs.add('Channel switched to: ${channelNumberString.trim()}');
    }
  }

  void _processSelectPreviousChannel(List<String> outputs) {
    tv.selectPreviousChannel();
    outputs.add('Switched to previous channel');
  }

  void _processSetChannelName(String rawCommand, List<String> outputs) {
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
    outputs.add('Channel name set: $channel - $name');
  }

  void _processDeleteChannelName(String rawCommand, List<String> outputs) {
    final parts = rawCommand.split(' ');
    if (parts.length < 2) {
      throw Exception('Invalid DeleteChannelName command');
    }

    final name = parts.sublist(1).join(' ').trim();
    tv.deleteChannelName(name);
    outputs.add('Channel name deleted: $name');
  }

  void _processGetChannelName(String rawCommand, List<String> outputs) {
    final parts = rawCommand.split(' ');
    if (parts.length != 2) {
      throw Exception('Invalid GetChannelName command');
    }

    final channel = int.tryParse(parts[1]);
    if (channel == null) {
      throw Exception('Invalid channel number');
    }

    final name = tv.getChannelName(channel);
    outputs.add(name != null ? 'Channel $channel name: $name' : 'ERROR');
  }

  void _processGetChannelByName(String rawCommand, List<String> outputs) {
    final parts = rawCommand.split(' ');
    if (parts.length < 2) {
      throw Exception('Invalid GetChannelByName command');
    }

    final name = parts.sublist(1).join(' ').trim();
    final channel = tv.getChannelByName(name);
    outputs.add(channel != null ? 'Channel for name $name: $channel' : 'ERROR');
  }
}

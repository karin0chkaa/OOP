import 'tv_set.dart';

class CommandProcessor {
  final TVSet tv;

  CommandProcessor(this.tv);

  void processCommands(List<String> commands) {
    for (final command in commands) {
      try {
        if (command == 'TurnOn') {
          _processTurnOn();
        } else if (command == 'TurnOff') {
          _processTurnOff();
        } else if (command == 'Info') {
          _processInfo();
        } else if (command.startsWith('SelectChannel')) {
          _processSelectChannel(command);
        } else if (command == 'SelectPreviousChannel') {
          _processSelectPreviousChannel();
        } else if (command.startsWith('SetChannelName')) {
          _processSetChannelName(command);
        } else if (command.startsWith('DeleteChannelName')) {
          _processDeleteChannelName(command);
        } else if (command.startsWith('GetChannelName')) {
          _processGetChannelName(command);
        } else if (command.startsWith('GetChannelByName')) {
          _processGetChannelByName(command);
        } else {
          print('ERROR');
        }
      } catch (e) {
        print('ERROR');
      }
    }
  }

  void _processTurnOn() {
    if (tv.turnOn()) {
      print('TV is turned on');
    } else {
      print('ERROR');
    }
  }

  void _processTurnOff() {
    if (tv.turnOff()) {
      print('TV is turned off');
    } else {
      print('ERROR');
    }
  }

  void _processInfo() {
    print(tv.info());
  }

  void _processSelectChannel(String rawCommand) {
    final commandParts = rawCommand.split(' ');
    if (commandParts.length != 2) {
      print('ERROR');
      return;
    }

    final channelNumberString = commandParts[1];
    final selectedChannel = int.tryParse(channelNumberString);

    if (selectedChannel != null) {
      if (selectedChannel < TVSet.minChannel ||
          selectedChannel > TVSet.maxChannel) {
        print('ERROR');
        return;
      }

      if (!tv.isOn) {
        print('ERROR: TV is turned off');
        return;
      }

      if (tv.selectChannel(selectedChannel)) {
        print('Channel switched to: $selectedChannel');
      } else {
        print('ERROR');
      }
    } else {
      if (!tv.isOn) {
        print('ERROR');
        return;
      }

      final name = channelNumberString.trim();

      if (tv.selectChannelByName(name)) {
        print('Channel switched to: $name');
      } else {
        print('ERROR');
      }
    }
  }

  void _processSelectPreviousChannel() {
    if (tv.selectPreviousChannel()) {
      print('Switched to previous channel');
    } else {
      print('ERROR');
    }
  }

  void _processSetChannelName(String rawCommand) {
    final commandParts = rawCommand.split(' ');
    if (commandParts.length < 3) {
      print('ERROR');
      return;
    }

    final channel = int.tryParse(commandParts[1]);
    if (channel == null) {
      print('ERROR');
      return;
    }

    final name = commandParts.sublist(2).join(' ').trim();
    if (name.isEmpty) {
      print('ERROR');
      return;
    }

    if (tv.setChannelName(channel, name)) {
      print('Channel name set: $channel - $name');
    } else {
      print('ERROR');
    }
  }

  void _processDeleteChannelName(String rawCommand) {
    final parts = rawCommand.split(' ');
    if (parts.length < 2) {
      print('ERROR');
      return;
    }

    final name = parts.sublist(1).join(' ').trim();
    if (name.isEmpty) {
      print('ERROR');
      return;
    }

    if (tv.deleteChannelName(name)) {
      print('Channel name deleted: $name');
    } else {
      print('ERROR');
    }
  }

  void _processGetChannelName(String rawCommand) {
    final parts = rawCommand.split(' ');
    if (parts.length != 2) {
      print('ERROR');
      return;
    }

    final channel = int.tryParse(parts[1]);
    if (channel == null) {
      print('ERROR');
      return;
    }

    final name = tv.getChannelName(channel);
    print(name != null ? 'Channel $channel name: $name' : 'ERROR');
  }

  void _processGetChannelByName(String rawCommand) {
    final parts = rawCommand.split(' ');
    if (parts.length < 2) {
      print('ERROR');
      return;
    }

    final name = parts.sublist(1).join(' ').trim();
    if (name.isEmpty) {
      print('ERROR');
      return;
    }

    final channel = tv.getChannelByName(name);
    print(channel != null ? 'Channel for name $name: $channel' : 'ERROR');
  }
}

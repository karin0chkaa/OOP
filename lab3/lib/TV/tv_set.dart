const int minChannel = 1;
const int maxChannel = 99;

class TVSet {
  bool _isOn = false;
  int _currentChannel = minChannel;
  int? _previousChannel;
  final Map<int, String> _channelNames = {};

  bool get isOn => _isOn;

  int get currentChannel => _isOn ? _currentChannel : 0;

  void turnOn() {
    if (_isOn) {
      throw Exception('TV is already on');
    }

    _isOn = true;
  }

  void turnOff() {
    if (!_isOn) {
      throw Exception('TV is already off');
    }

    _isOn = false;
  }

  void selectChannel(int channel) {
    if (!_isOn) {
      throw Exception('TV is turned off');
    }

    if (channel < minChannel || channel > maxChannel) {
      throw Exception('Channel must be between $minChannel and $maxChannel');
    }

    if (channel == _currentChannel) {
      return;
    }

    _previousChannel = _currentChannel;
    _currentChannel = channel;
  }

  void selectPreviousChannel() {
    if (!_isOn) {
      throw Exception('TV is turned off');
    }

    if (_previousChannel == null) {
      throw Exception('No previous channel to return to');
    }

    _currentChannel = _previousChannel!;
    _previousChannel = null;
  }

  void selectChannelByName(String name) {
    if (!_isOn) {
      throw Exception('TV is turned off');
    }

    final trimmedName = name.trim();
    final channel = _getChannelByName(trimmedName);
    if (channel == null) {
      throw Exception('No channel found with name "$trimmedName"');
    }

    return selectChannel(channel);
  }

  void setChannelName(int channel, String name) {
    if (!_isOn) {
      throw Exception('TV is turned off');
    }

    if (channel < minChannel || channel > maxChannel) {
      throw Exception('Channel must be between $minChannel and $maxChannel');
    }

    final trimmedName = name.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (trimmedName.isEmpty) {
      throw Exception('Channel name cannot be empty or whitespace');
    }

    final oldChannel = _getChannelByName(trimmedName);
    if (oldChannel != null) {
      _channelNames.remove(oldChannel);
    }

    _channelNames[channel] = trimmedName;
  }

  void deleteChannelName(String name) {
    if (!_isOn) {
      throw Exception('TV is turned off');
    }

    final trimmedName = name.trim();
    final channel = _getChannelByName(trimmedName);
    if (channel == null) {
      throw Exception('No channel found with name "$trimmedName"');
    }

    _channelNames.remove(channel);
  }

  String? getChannelName(int channel) {
    if (!_isOn) {
      throw Exception('TV is turned off');
    }

    if (channel < minChannel || channel > maxChannel) {
      throw Exception('Channel must be between $minChannel and $maxChannel');
    }

    return _channelNames[channel];
  }

  int? getChannelByName(String name) {
    if (!_isOn) {
      throw Exception('TV is turned off');
    }

    return _getChannelByName(name.trim());
  }

  int? _getChannelByName(String name) {
    for (final channelEntry in _channelNames.entries) {
      if (channelEntry.value == name) {
        return channelEntry.key;
      }
    }

    return null;
  }
}

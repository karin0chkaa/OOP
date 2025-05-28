class TVSet {
  static const int minChannel = 1;
  static const int maxChannel = 99;

  bool _isOn = false;
  int _currentChannel = 1;
  int? _previousChannel;
  final Map<int, String> _channelNames = {};
  final Map<String, int> _nameToChannel = {};

  bool get isOn => _isOn;

  int get currentChannel => _isOn ? _currentChannel : 0;

  bool turnOn() {
    if (_isOn) {
      return false;
    }

    _isOn = true;
    return true;
  }

  bool turnOff() {
    if (!_isOn) {
      return true;
    }

    _isOn = false;
    return true;
  }

  bool selectChannel(int channel) {
    if (!_isOn || channel < minChannel || channel > maxChannel) {
      return false;
    }

    _previousChannel = _currentChannel;
    _currentChannel = channel;
    return true;
  }

  bool selectPreviousChannel() {
    if (!_isOn || _previousChannel == null) {
      return false;
    }

    final temp = _currentChannel;
    _currentChannel = _previousChannel!;
    _previousChannel = temp;
    return true;
  }

  bool selectChannelByName(String name) {
    if (!_isOn) {
      return false;
    }

    final channel = _nameToChannel[name];
    if (channel == null) {
      return false;
    }

    return selectChannel(channel);
  }

  bool setChannelName(int channel, String name) {
    if (!_isOn || channel < minChannel || channel > maxChannel) {
      return false;
    }

    final trimmedName = name.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (trimmedName.isEmpty) {
      return false;
    }

    if (_channelNames.containsKey(channel)) {
      final oldName = _channelNames[channel];
      _nameToChannel.remove(oldName);
    }

    if (_nameToChannel.containsKey(trimmedName)) {
      final oldChannel = _nameToChannel[trimmedName]!;
      _channelNames.remove(oldChannel);
    }

    _channelNames[channel] = trimmedName;
    _nameToChannel[trimmedName] = channel;

    return true;
  }

  bool deleteChannelName(String name) {
    if (!_isOn) {
      return false;
    }

    final trimmedName = name.trim();
    if (!_nameToChannel.containsKey(trimmedName)) {
      return false;
    }

    final channel = _nameToChannel[trimmedName]!;
    _nameToChannel.remove(trimmedName);
    _channelNames.remove(channel);
    return true;
  }

  String? getChannelName(int channel) {
    if (!_isOn || channel < minChannel || channel > maxChannel) {
      return null;
    }

    return _channelNames[channel];
  }

  int? getChannelByName(String name) {
    if (!_isOn) {
      return null;
    }

    return _nameToChannel[name.trim()];
  }

  String info() {
    if (!_isOn) {
      return 'TV is turned off';
    }

    final info = StringBuffer('TV is turned on\nChannel is: $_currentChannel');

    if (_channelNames.isNotEmpty) {
      final sortedChannels = _channelNames.keys.toList()..sort();

      for (final channel in sortedChannels) {
        info.write('\n$channel - ${_channelNames[channel]}');
      }
    }

    return info.toString();
  }
}

class StringUtils {
  String findAndReplace(String subject, String search, String replace) {
    if (search.isEmpty) {
      return subject;
    }

    String result = "";
    int index = 0;

    while (index < subject.length) {
      int nextIndex = subject.indexOf(search, index);

      if (nextIndex == -1) {
        result += subject.substring(index);
        break;
      } else {
        result += subject.substring(index, nextIndex);

        result += replace;

        index = nextIndex + search.length;
      }
    }

    return result.toString();
  }

  String htmlDecode(String html) {
    final result = StringBuffer();
    final length = html.length;
    var i = 0;

    while (i < length) {
      final ch = html[i];
      if (ch == '&') {
        var end = html.indexOf(';', i);
        if (end != -1) {
          final entity = html.substring(i, end + 1);
          final decoded = _decodeEntity(entity);
          result.write(decoded);
          i = end + 1;
          continue;
        }
      }

      result.write(ch);
      i++;
    }

    return result.toString();
  }

  String _decodeEntity(String entity) {
    switch (entity) {
      case '&quot;':
        return '"';
      case '&apos;':
        return "'";
      case '&lt;':
        return '<';
      case '&gt;':
        return '>';
      case '&amp;':
        return '&';
      default:
        return entity;
    }
  }
}
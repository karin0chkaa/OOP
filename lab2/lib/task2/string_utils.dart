class StringUtils {
  String findAndReplace(String subject, String search, String replace) {
    if (search.isEmpty) {
      return subject;
    }

    final result = StringBuffer();
    final searchLength = search.length;
    final subjectLength = subject.length;

    for (int i = 0; i < subjectLength; i++) {
      if (i <= subjectLength - searchLength) {
        bool isMatch = true;
        for (int j = 0; j < searchLength; j++) {
          if (subject[i + j] != search[j]) {
            isMatch = false;
            break;
          }
        }

        if (isMatch) {
          result.write(replace);
          i += searchLength - 1;
          continue;
        }
      }
      result.write(subject[i]);
    }
    return result.toString();
  }

  String htmlDecode(String html) {
    final result = StringBuffer();
    final length = html.length;
    var i = 0;

    for (int i = 0; i < length; i++) {
      final ch = html[i];
      if (ch == '&') {
        final entityBuffer = StringBuffer('&');
        int j = i + 1;
        bool foundSemicolon = false;

        while (j < length && j < i + 100000) {
          final nextCh = html[j];
          entityBuffer.write(nextCh);

          if (nextCh == ';') {
            foundSemicolon = true;
            break;
          }
          j++;
        }

        if (foundSemicolon) {
          final entity = entityBuffer.toString();
          final decoded = _decodeEntity(entity);
          result.write(decoded);
          i = j;
        } else {
          result.write(ch);
        }
      } else {
        result.write(ch);
      }
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

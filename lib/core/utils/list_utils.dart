class ListUtils {
  static String textJoiner<T>(
      {required List<T> list,
      ItemSeparator? separatorType,
      String? customSeparator = ', ',
      required String Function(T) builder}) {
    var textSeparator = ', ';
    if (customSeparator != null) {
      textSeparator = customSeparator;
    } else {
      switch (separatorType) {
        case ItemSeparator.comma:
          textSeparator = ', ';
          break;
        case ItemSeparator.tile:
          textSeparator = ' | ';
          break;
        default:
          break;
      }
    }

    var text = '';
    for (int i = 0; i < list.length; i++) {
      if (i == 0) {
        text = builder(list[i]);
      } else {
        text = '$text $textSeparator ${builder(list[i])}';
      }
    }

    return text;
  }
}

enum ItemSeparator { comma, tile }

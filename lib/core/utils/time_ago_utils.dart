import 'package:timeago/timeago.dart' as timeago;

String shortTimeAgo(DateTime? dateTime) {
  if (dateTime == null) {
    return 'N/A';
  }

  var agoValue = timeago.format(dateTime, locale: 'fr_short');
  return agoValue == 'maintenant' ? agoValue : '$agoValue avant';
}

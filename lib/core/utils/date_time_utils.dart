import 'package:intl/intl.dart';

DateTime? parseDate(String? dateString) {
  if (dateString == null || dateString == '') {
    return null;
  }

  try {
    return DateTime.parse(dateString).toLocal();
  } catch (e) {
    return null;
  }
}

DateTime getNowAppTime() {
  return DateTime.now().toLocal();
}

class DUStringUtils {
  static String? getTimeString12h(String? dateString) {
    if (dateString == null) {
      return null;
    }

    var date = DateTime.parse(dateString);
    return DateFormat('h:mm a').format(date.toLocal());
  }
}

class DUDateUtils {
  static String? getTimeString12h(DateTime? date) {
    if (date == null) {
      return null;
    }
    return DateFormat('h:mm a').format(date.toLocal());
  }

  static String? getTimeString24h(DateTime? date) {
    if (date == null) {
      return null;
    }
    return DateFormat('HH:mm').format(date.toLocal());
  }
}

class DateTimeUtils {
  static String getNowUtcString() {
    var nowUtc = DateTime.now().toUtc();
    return nowUtc.toIso8601String();
  }

  static var _24HoursInMinutes = (24 * 60);

  static String? readableDateString(DateTime? date) {
    if (date == null) {
      return null;
    }
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static readableDate(DateTime? dateTime) {
    try {
      String formattedDate = DateFormat('dd MMM yyyy').format(dateTime!);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  static readableDateDDMMYY(DateTime dateTime) {
    try {
      String formattedDate = DateFormat('dd (EEE), MMM yy').format(dateTime);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  static readableDateEEEMMMYY(DateTime dateTime) {
    try {
      String formattedDate = DateFormat('EEE, MMM yy').format(dateTime);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  static readableDateEEEMMMDD(DateTime dateTime) {
    try {
      String formattedDate = DateFormat('EEE, MMM dd').format(dateTime);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  static readableDateMMMDDYYYY(DateTime dateTime) {
    try {
      String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  static readableDateDDMM(DateTime dateTime) {
    try {
      String formattedDate = DateFormat('dd, MMM').format(dateTime);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  static String epochToReadableTime(int? minutes) {
    if (minutes == null) {
      return '';
    }

    minutes = minutes * 60000;
    var date = DateTime.fromMillisecondsSinceEpoch(minutes).toLocal();
    String formattedDate = DateFormat('hh:mm a').format(date.toLocal());
    return formattedDate;
  }

  // UTC UTILS

  static Time getUtcHourMinutesFromUtcTime(int? minutes) {
    minutes ??= 0;
    var hour = minutes ~/ 60;
    var remaining = minutes % 60;
    return Time(hour: hour, minutes: remaining);
  }

  static int getNowUtcTimeInMinutes() {
    var now = DateTime.now().toUtc();
    return (now.hour * 60) + now.minute;
  }

  static int getAppCurrentUtcYear() {
    var now = DateTime.now().toUtc();
    return now.year;
  }

  static int getAppCurrentUtcMonth() {
    var now = DateTime.now().toUtc();
    return now.month;
  }

  static int getAppCurrentUtcDay() {
    var now = DateTime.now().toUtc();
    return now.day;
  }

  static int getAppUtcYear(DateTime dateTime) {
    var now = dateTime.toUtc();
    return now.year;
  }

  static int getAppUtcMonth(DateTime dateTime) {
    var now = dateTime.toUtc();
    return now.month;
  }

  static int getAppUtcDay(DateTime dateTime) {
    var now = dateTime.toUtc();
    return now.day;
  }

  static Date getUtcDateYMD(DateTime? dateTime) {
    dateTime ??= DateTime.now();
    if (dateTime.isUtc) {
      return Date(dateTime.year, dateTime.month, dateTime.day);
    } else {
      var utcDate = dateTime.toUtc();
      return Date(utcDate.year, utcDate.month, utcDate.day);
    }
  }

// For given utc minutes this function outputs the equivalent local time in minutes
  static int getLocalMinutesFromUtcMinutes(int minutesInUtc) {
    var utcOffsetInMinutes = DateTime.now().timeZoneOffset.inMinutes;
    var localTimeInMinutes = minutesInUtc + utcOffsetInMinutes;

    while (localTimeInMinutes <= 0) {
      localTimeInMinutes = _24HoursInMinutes + localTimeInMinutes;
    }

    while (localTimeInMinutes > _24HoursInMinutes) {
      localTimeInMinutes = _24HoursInMinutes - localTimeInMinutes;
    }
    return localTimeInMinutes;
  }

// Output in local time 12 hours format
// Example: 11:00 AM, 01:00 PM
  static String getLocalHourMinutes12String(int? minutes) {
    minutes ??= 0;
    var utcOffsetInMinutes = DateTime.now().timeZoneOffset.inMinutes;
    minutes = minutes + utcOffsetInMinutes;

    while (minutes! <= 0) {
      minutes = _24HoursInMinutes + minutes;
    }

    while (minutes! > _24HoursInMinutes) {
      minutes = _24HoursInMinutes - minutes;
    }

    var hour = minutes ~/ 60;
    var remaining = minutes % 60;
    var s = 'AM';

    if (hour > 12) {
      s = 'PM';
      hour = hour - 12;
    }

    var hourString = hour.toString().padLeft(2, '0');
    var minuteString = remaining.toString().padLeft(2, '0');

    return '$hourString:$minuteString $s';
  }

// Output in local time 24 hours format
// Example: 11:00, 16:00
  static String getLocalHourMinutes24String(int? minutes) {
    minutes ??= 0;
    var utcOffsetInMinutes = DateTime.now().timeZoneOffset.inMinutes;
    minutes = minutes + utcOffsetInMinutes;

    while (minutes! <= 0) {
      minutes = _24HoursInMinutes + minutes;
    }

    while (minutes! > _24HoursInMinutes) {
      minutes = _24HoursInMinutes - minutes;
    }

    var hour = minutes ~/ 60;
    var remaining = minutes % 60;

    var hourString = hour.toString().padLeft(2, '0');
    var minuteString = remaining.toString().padLeft(2, '0');

    return '$hourString:$minuteString';
  }

// Hour minutes string in 12 hours format
// Example: 11:00 AM, 01:00 PM
  static String getHourMinutes12hString(int? minutes) {
    minutes ??= 0;
    var hour = minutes ~/ 60;
    var remaining = minutes % 60;
    var s = 'AM';

    if (hour > 12) {
      s = 'PM';
      hour = hour - 12;
    }

    var hourString = hour.toString().padLeft(2, '0');
    var minuteString = remaining.toString().padLeft(2, '0');

    return '$hourString:$minuteString $s';
  }

  static String getHourMinutesStringhm(int? minutes) {
    if (minutes == null) {
      return '0 m';
    }
    if (minutes < 60) {
      return '$minutes m';
    } else {
      var hour = minutes ~/ 60;
      var remaining = minutes % 60;

      return '$hour hr $remaining m';
    }
  }

  static int getUtcTimeNowInMinutes() {
    var nowUtc = DateTime.now().toUtc();
    var nowUtcInMinutes = (nowUtc.hour * 60) + nowUtc.minute;
    return nowUtcInMinutes;
  }

  static DateTime? YMDTtoDateTime(int year, int month, int day, int time) {
    if (year == 0) {
      return null;
    }
    return DateTime.utc(year, month + 1, day).add(Duration(minutes: time));
  }
}

class Date {
  final int year;
  final int month;
  final int day;

  Date(this.year, this.month, this.day);
}

class Time {
  final int hour;
  final int minutes;

  Time({required this.hour, required this.minutes});
}

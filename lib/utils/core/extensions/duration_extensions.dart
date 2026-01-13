import 'package:intl/intl.dart';

import 'string_extensions.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  String formatDate([String format = 'dd-MM-yyyy']) {
    return DateFormat(format).format(this);
  }

  DateTime get eighteenYearsAgo {
    final today = DateTime.now();
    final eighteen = DateTime(today.year - 18, today.month, today.day - 1);
    return eighteen;
  }
}

extension DurationExtensions on Duration {
  String get toHoursMinutes {
    return RegExp(r'^(\d+):(\d+):\d+\.')
        .firstMatch(toString())!
        .groups([1, 2])
        .map((e) => e!.toNumFormat)
        .join(':');
  }

  String get toHoursMinutesSeconds {
    return RegExp(r'^(\d+):(\d+):(\d+)\.')
        .firstMatch(toString())!
        .groups([1, 2, 3])
        .map((e) => e!.toNumFormat)
        .join(':');
  }

  String get toMinutesSeconds {
    return RegExp(r'^(\d+):(\d+):(\d+)\.')
        .firstMatch(toString())!
        .groups([2, 3])
        .map((e) => e!.toNumFormat)
        .join(':');
  }
}

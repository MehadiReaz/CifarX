import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  // Formatting
  String get ddMMyyyy => DateFormat('dd/MM/yyyy').format(this);
  String get mmDDyyyy => DateFormat('MM/dd/yyyy').format(this);
  String get yyyyMMdd => DateFormat('yyyy-MM-dd').format(this);
  String get ddMMM => DateFormat('dd MMM').format(this);
  String get ddMMMyyy => DateFormat('dd MMM yyyy').format(this);
  String get timeOnly => DateFormat('HH:mm').format(this);
  String get timeWithSeconds => DateFormat('HH:mm:ss').format(this);
  String get dateTimeFormatted => DateFormat('dd/MM/yyyy HH:mm').format(this);

  // Relative time
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? '1 hour ago'
          : '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 minute ago'
          : '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  // Date comparisons
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  // Start/End of day
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  // Add/subtract periods
  DateTime addDays(int days) => add(Duration(days: days));
  DateTime subtractDays(int days) => subtract(Duration(days: days));
  DateTime addHours(int hours) => add(Duration(hours: hours));
  DateTime subtractHours(int hours) => subtract(Duration(hours: hours));
}

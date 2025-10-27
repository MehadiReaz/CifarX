extension StringExtensions on String {
  // Validation
  bool get isValidEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(this);
  }

  bool get isValidPhone {
    return RegExp(r'^[+]?[0-9]{10,15}$').hasMatch(this);
  }

  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  // Capitalization
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  // Truncation
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  // Remove HTML tags
  String get removeHtmlTags {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }

  // Parse to int safely
  int? get toIntOrNull {
    return int.tryParse(this);
  }

  // Parse to double safely
  double? get toDoubleOrNull {
    return double.tryParse(this);
  }

  // Check if string is null or empty
  bool get isNullOrEmpty {
    return isEmpty;
  }

  // Add ellipsis to long text
  String ellipsis(int maxLength) {
    return length > maxLength ? '${substring(0, maxLength)}...' : this;
  }
}

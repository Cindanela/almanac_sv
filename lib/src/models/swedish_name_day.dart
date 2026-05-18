/// A class representing the official Swedish name day(s) for a specific date.
class SwedishNameDay {
  /// The month (1-12) of this name day.
  final int month;

  /// The day of the month (1-31) of this name day.
  final int day;

  /// The list of official names associated with this date (can be empty, e.g., for Christmas Day or New Year's Day).
  final List<String> names;

  /// Creates a [SwedishNameDay] instance.
  const SwedishNameDay({
    required this.month,
    required this.day,
    required this.names,
  });

  @override
  String toString() => 'SwedishNameDay($month/$day: ${names.join(', ')})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SwedishNameDay &&
        other.month == month &&
        other.day == day &&
        _listEquals(other.names, names);
  }

  @override
  int get hashCode => month.hashCode ^ day.hashCode ^ names.hashCode;

  static bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

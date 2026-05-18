/// A class representing a Swedish holiday or important calendar day.
class SwedishHoliday {
  /// The date of the holiday. Time is always set to 00:00:00.
  final DateTime date;

  /// The name of the holiday in Swedish (e.g., "Midsommarafton").
  final String name;

  /// Whether this day is an official public holiday ("Röd dag").
  final bool isRedDay;

  /// Whether this day is typically bank-free (banks and most offices are closed).
  /// This includes all red days, plus Christmas Eve, New Year's Eve, and Midsummer Eve.
  final bool isBankFreeDay;

  /// Whether this day is an official Swedish flag day.
  final bool isFlagDay;

  /// Creates a [SwedishHoliday] instance with the specified properties.
  const SwedishHoliday({
    required this.date,
    required this.name,
    this.isRedDay = false,
    this.isBankFreeDay = false,
    this.isFlagDay = false,
  });

  @override
  String toString() {
    return 'SwedishHoliday(name: $name, date: ${date.toIso8601String().substring(0, 10)}, isRedDay: $isRedDay, isBankFreeDay: $isBankFreeDay, isFlagDay: $isFlagDay)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SwedishHoliday &&
      other.date == date &&
      other.name == name &&
      other.isRedDay == isRedDay &&
      other.isBankFreeDay == isBankFreeDay &&
      other.isFlagDay == isFlagDay;
  }

  @override
  int get hashCode {
    return date.hashCode ^
      name.hashCode ^
      isRedDay.hashCode ^
      isBankFreeDay.hashCode ^
      isFlagDay.hashCode;
  }
}

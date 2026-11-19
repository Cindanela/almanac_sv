/// Extension methods for [DateTime] to support Swedish calendar and almanac features.
extension SwedishDateTimeExtensions on DateTime {
  /// Calculates the ISO-8601 week number for this date.
  /// 
  /// In Sweden, ISO-8601 week numbers are the standard. 
  /// Week 1 is defined as the week with the year's first Thursday in it.
  int get weekNumber {
    // UTC, so the day count has no DST switch in it: a local-time difference
    // across the March switch is 23 h short and `inDays` drops a day.
    final thursday = DateTime.utc(year, month, day + DateTime.thursday - weekday);

    // The year of this Thursday is the "week year" (which can be different from the date's year around New Year's)
    final firstDayOfYear = DateTime.utc(thursday.year, 1, 1);

    final daysToThursday = thursday.difference(firstDayOfYear).inDays;

    // Week number is 1 + the number of full weeks
    return 1 + (daysToThursday ~/ 7);
  }

  /// Returns the full weekday name in Swedish (e.g., "måndag", "tisdag").
  String get weekdayNameSv {
    switch (weekday) {
      case DateTime.monday:
        return 'måndag';
      case DateTime.tuesday:
        return 'tisdag';
      case DateTime.wednesday:
        return 'onsdag';
      case DateTime.thursday:
        return 'torsdag';
      case DateTime.friday:
        return 'fredag';
      case DateTime.saturday:
        return 'lördag';
      case DateTime.sunday:
        return 'söndag';
      default:
        return '';
    }
  }

  /// Returns the abbreviated 3-letter weekday name in Swedish (e.g., "mån", "tis").
  String get weekdayNameShortSv {
    switch (weekday) {
      case DateTime.monday:
        return 'mån';
      case DateTime.tuesday:
        return 'tis';
      case DateTime.wednesday:
        return 'ons';
      case DateTime.thursday:
        return 'tor';
      case DateTime.friday:
        return 'fre';
      case DateTime.saturday:
        return 'lör';
      case DateTime.sunday:
        return 'sön';
      default:
        return '';
    }
  }

  /// Returns the full month name in Swedish (e.g., "januari", "februari").
  String get monthNameSv {
    switch (month) {
      case 1:
        return 'januari';
      case 2:
        return 'februari';
      case 3:
        return 'mars';
      case 4:
        return 'april';
      case 5:
        return 'maj';
      case 6:
        return 'juni';
      case 7:
        return 'juli';
      case 8:
        return 'augusti';
      case 9:
        return 'september';
      case 10:
        return 'oktober';
      case 11:
        return 'november';
      case 12:
        return 'december';
      default:
        return '';
    }
  }

  /// Returns the abbreviated 3-letter month name in Swedish (e.g., "jan", "feb").
  String get monthNameShortSv {
    switch (month) {
      case 1:
        return 'jan';
      case 2:
        return 'feb';
      case 3:
        return 'mar';
      case 4:
        return 'apr';
      case 5:
        return 'maj';
      case 6:
        return 'jun';
      case 7:
        return 'jul';
      case 8:
        return 'aug';
      case 9:
        return 'sep';
      case 10:
        return 'okt';
      case 11:
        return 'nov';
      case 12:
        return 'dec';
      default:
        return '';
    }
  }
}

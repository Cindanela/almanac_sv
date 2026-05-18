/// A comprehensive Dart and Flutter package for the Swedish almanac: public holidays (röda dagar), flag days, name days (namnsdagar), bank-free days, and ISO week numbers.
library;

export 'src/models/swedish_holiday.dart';
export 'src/models/swedish_name_day.dart';
export 'src/extensions/date_time_extensions.dart';
import 'src/models/swedish_holiday.dart';
import 'src/models/swedish_name_day.dart';
import 'src/holidays_calculator.dart';
import 'src/name_days_data.dart';

/// Main entry point for the almanac_sv package.
class AlmanacSv {
  // Prevent instantiation of this static utility class.
  AlmanacSv._();

  /// Returns a list of all named Swedish holidays and important calendar days for the given [year].
  static List<SwedishHoliday> getAllHolidays(int year) {
    return HolidaysCalculator.getHolidays(year);
  }

  /// Returns a list of all bank-free days (days where banks and most offices are closed) for the given [year].
  /// This includes all official red days, plus Midsummer Eve, Christmas Eve, and New Year's Eve.
  static List<SwedishHoliday> getBankFreeDays(int year) {
    return HolidaysCalculator.getHolidays(year)
        .where((h) => h.isBankFreeDay)
        .toList();
  }

  /// Returns a list of all official red days (public holidays) for the given [year].
  /// Note: Sundays are inherently red days in Sweden, but this function only returns the specifically named holidays.
  static List<SwedishHoliday> getRedDays(int year) {
    return HolidaysCalculator.getHolidays(year)
        .where((h) => h.isRedDay)
        .toList();
  }

  /// Returns information about a specific date if it is a named holiday or important day.
  /// Returns null if the date is not a named holiday.
  static SwedishHoliday? getHolidayInfo(DateTime date) {
    final holidays = HolidaysCalculator.getHolidays(date.year);
    final targetDate = DateTime(date.year, date.month, date.day);

    for (var holiday in holidays) {
      if (holiday.date == targetDate) {
        return holiday;
      }
    }
    return null;
  }

  /// Checks if a specific date is an official red day (public holiday).
  /// Note: Sundays are inherently red days in Sweden, so this returns true for all Sundays
  /// as well as any other specific named red days.
  static bool isRedDay(DateTime date) {
    if (date.weekday == DateTime.sunday) return true;
    final info = getHolidayInfo(date);
    return info?.isRedDay ?? false;
  }

  /// Checks if a specific date is the day before an official red day.
  /// This is highly useful for determining half-days (klämdagar/halvdagar) which are
  /// often defined by union contracts as "the day before a red day".
  static bool isDayBeforeRedDay(DateTime date) {
    if (date.weekday == DateTime.saturday) return true;
    
    final tomorrow = date.add(const Duration(days: 1));
    return isRedDay(tomorrow);
  }

  /// Returns the official Swedish name day(s) for a specific [date].
  static SwedishNameDay getNameDay(DateTime date) {
    final names = swedishNameDays[date.month]?[date.day] ?? [];
    return SwedishNameDay(month: date.month, day: date.day, names: names);
  }

  /// Returns a list of all official Swedish name days for the given [month] (1-12).
  static List<SwedishNameDay> getNameDaysForMonth(int month) {
    final monthData = swedishNameDays[month] ?? {};
    return monthData.entries
        .map((e) => SwedishNameDay(month: month, day: e.key, names: e.value))
        .toList();
  }
}

import 'models/swedish_holiday.dart';

/// A utility class for calculating Swedish holidays.
class HolidaysCalculator {
  /// Calculates the date of Easter Sunday (Påskdagen) for a given year.
  /// Uses the Meeus/Jones/Butcher algorithm for the Gregorian calendar.
  static DateTime getEasterSunday(int year) {
    final a = year % 19;
    final b = year ~/ 100;
    final c = year % 100;
    final d = b ~/ 4;
    final e = b % 4;
    final f = (b + 8) ~/ 25;
    final g = (b - f + 1) ~/ 3;
    final h = (19 * a + b - d - g + 15) % 30;
    final i = c ~/ 4;
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = (a + 11 * h + 22 * l) ~/ 451;
    final month = (h + l - 7 * m + 114) ~/ 31;
    final day = ((h + l - 7 * m + 114) % 31) + 1;
    
    return DateTime(year, month, day);
  }

  /// Calculates all Swedish holidays and important calendar days for a given year.
  static List<SwedishHoliday> getHolidays(int year) {
    final easterSunday = getEasterSunday(year);
    
    // Calendar arithmetic, not `add(Duration)`: a local-time day across a DST
    // switch is 23 or 25 hours, which lands on 23:00 the day before.
    DateTime addDays(DateTime date, int days) =>
        DateTime(date.year, date.month, date.day + days);
    
    // Midsommarafton: Friday between June 19 and June 25
    final DateTime june19 = DateTime(year, 6, 19);
    final int daysToFridayMidsummer = (DateTime.friday - june19.weekday + 7) % 7;
    final DateTime midsommarafton = addDays(june19, daysToFridayMidsummer);
    final DateTime midsommardagen = addDays(midsommarafton, 1);

    // Alla helgons dag: Saturday between October 31 and November 6
    final DateTime oct31 = DateTime(year, 10, 31);
    final int daysToSaturdayAllSaints = (DateTime.saturday - oct31.weekday + 7) % 7;
    final DateTime allaHelgonsDag = addDays(oct31, daysToSaturdayAllSaints);
    final DateTime allaHelgonsAfton = addDays(allaHelgonsDag, -1);

    // Val till riksdagen (Election day) is every 4 years (e.g. 2014, 2018, 2022, 2026).
    // Held on the second Sunday of September.
    DateTime? electionDay;
    if (year >= 2014 && year % 4 == 2) {
      final sept1 = DateTime(year, 9, 1);
      final daysToFirstSunday = (DateTime.sunday - sept1.weekday + 7) % 7;
      electionDay = addDays(sept1, daysToFirstSunday + 7);
    }

    final List<SwedishHoliday> holidays = [
      // --- Static Days ---
      SwedishHoliday(
        date: DateTime(year, 1, 1),
        name: 'Nyårsdagen',
        isRedDay: true,
        isBankFreeDay: true,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 1, 6),
        name: 'Trettondedag jul',
        isRedDay: true,
        isBankFreeDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 1, 28),
        name: 'Konungens namnsdag',
        isRedDay: false,
        isBankFreeDay: false,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 2, 14),
        name: 'Alla hjärtans dag',
        isRedDay: false,
        isBankFreeDay: false,
      ),
      SwedishHoliday(
        date: DateTime(year, 3, 12),
        name: 'Kronprinsessans namnsdag',
        isRedDay: false,
        isBankFreeDay: false,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 4, 30),
        name: 'Valborgsmässoafton',
        isRedDay: false,
        isBankFreeDay: false,
        isFlagDay: true, // Konungens födelsedag
      ),
      SwedishHoliday(
        date: DateTime(year, 5, 1),
        name: 'Första maj',
        isRedDay: true,
        isBankFreeDay: true,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 6, 6),
        name: 'Sveriges nationaldag',
        isRedDay: true,
        isBankFreeDay: true,
        isFlagDay: true, // Svenska flaggans dag
      ),
      SwedishHoliday(
        date: DateTime(year, 7, 14),
        name: 'Kronprinsessans födelsedag',
        isRedDay: false,
        isBankFreeDay: false,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 8, 8),
        name: 'Drottningens namnsdag',
        isRedDay: false,
        isBankFreeDay: false,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 10, 24),
        name: 'FN-dagen',
        isRedDay: false,
        isBankFreeDay: false,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 11, 6),
        name: 'Gustav Adolfsdagen',
        isRedDay: false,
        isBankFreeDay: false,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 12, 10),
        name: 'Nobeldagen',
        isRedDay: false,
        isBankFreeDay: false,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 12, 23),
        name: 'Drottningens födelsedag',
        isRedDay: false,
        isBankFreeDay: false,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 12, 24),
        name: 'Julafton',
        isRedDay: false,
        isBankFreeDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 12, 25),
        name: 'Juldagen',
        isRedDay: true,
        isBankFreeDay: true,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 12, 26),
        name: 'Annandag jul',
        isRedDay: true,
        isBankFreeDay: true,
      ),
      SwedishHoliday(
        date: DateTime(year, 12, 31),
        name: 'Nyårsafton',
        isRedDay: false,
        isBankFreeDay: true,
      ),

      // --- Dynamic Days (Easter based) ---
      SwedishHoliday(
        date: addDays(easterSunday, -3),
        name: 'Skärtorsdagen',
        isRedDay: false,
        isBankFreeDay: false,
      ),
      SwedishHoliday(
        date: addDays(easterSunday, -2),
        name: 'Långfredagen',
        isRedDay: true,
        isBankFreeDay: true,
      ),
      SwedishHoliday(
        date: addDays(easterSunday, -1),
        name: 'Påskafton',
        isRedDay: false,
        isBankFreeDay: true, // Saturdays are technically bank-free
      ),
      SwedishHoliday(
        date: easterSunday,
        name: 'Påskdagen',
        isRedDay: true,
        isBankFreeDay: true,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: addDays(easterSunday, 1),
        name: 'Annandag påsk',
        isRedDay: true,
        isBankFreeDay: true,
      ),
      SwedishHoliday(
        date: addDays(easterSunday, 39),
        name: 'Kristi himmelsfärdsdag',
        isRedDay: true,
        isBankFreeDay: true,
      ),
      SwedishHoliday(
        date: addDays(easterSunday, 48),
        name: 'Pingstafton',
        isRedDay: false,
        isBankFreeDay: true, // Saturdays are technically bank-free
      ),
      SwedishHoliday(
        date: addDays(easterSunday, 49),
        name: 'Pingstdagen',
        isRedDay: true,
        isBankFreeDay: true,
        isFlagDay: true,
      ),

      // --- Dynamic Days (Rule based) ---
      SwedishHoliday(
        date: midsommarafton,
        name: 'Midsommarafton',
        isRedDay: false,
        isBankFreeDay: true,
      ),
      SwedishHoliday(
        date: midsommardagen,
        name: 'Midsommardagen',
        isRedDay: true,
        isBankFreeDay: true,
        isFlagDay: true,
      ),
      SwedishHoliday(
        date: allaHelgonsAfton,
        name: 'Alla helgons afton',
        isRedDay: false,
        isBankFreeDay: false,
      ),
      SwedishHoliday(
        date: allaHelgonsDag,
        name: 'Alla helgons dag',
        isRedDay: true,
        isBankFreeDay: true,
      ),
    ];

    if (electionDay != null) {
      holidays.add(
        SwedishHoliday(
          date: electionDay,
          name: 'Val till riksdagen',
          isRedDay: false,
          isBankFreeDay: false,
          isFlagDay: true,
        ),
      );
    }

    holidays.sort((a, b) => a.date.compareTo(b.date));
    return holidays;
  }
}

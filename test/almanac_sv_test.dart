import 'package:test/test.dart';
import 'package:almanac_sv/almanac_sv.dart';
import 'package:almanac_sv/src/holidays_calculator.dart';

void main() {
  group('Holidays Calculator Tests', () {
    test('calculate Easter Sunday correctly for various years', () {
      expect(HolidaysCalculator.getEasterSunday(2023), DateTime(2023, 4, 9));
      expect(HolidaysCalculator.getEasterSunday(2024), DateTime(2024, 3, 31));
      expect(HolidaysCalculator.getEasterSunday(2025), DateTime(2025, 4, 20));
      expect(HolidaysCalculator.getEasterSunday(2026), DateTime(2026, 4, 5));
    });

    test('Midsommarafton should be on Friday between June 19 and 25', () {
      final holidays2024 = HolidaysCalculator.getHolidays(2024);
      final midsummer2024 = holidays2024.firstWhere((h) => h.name == 'Midsommarafton');
      expect(midsummer2024.date, DateTime(2024, 6, 21));
      expect(midsummer2024.date.weekday, DateTime.friday);
    });

    test('Alla helgons dag should be Saturday between Oct 31 and Nov 6', () {
      final holidays2024 = HolidaysCalculator.getHolidays(2024);
      final allaHelgonsDag2024 = holidays2024.firstWhere((h) => h.name == 'Alla helgons dag');
      expect(allaHelgonsDag2024.date, DateTime(2024, 11, 2));
      expect(allaHelgonsDag2024.date.weekday, DateTime.saturday);
    });

    test('getBankFreeDays filters correctly', () {
      final bankFree2024 = AlmanacSv.getBankFreeDays(2024);
      expect(bankFree2024.any((h) => h.name == 'Valborgsmässoafton'), isFalse);
      expect(bankFree2024.any((h) => h.name == 'Julafton'), isTrue);
      expect(bankFree2024.any((h) => h.name == 'Juldagen'), isTrue);
    });

    test('getRedDays filters correctly', () {
      final redDays2024 = AlmanacSv.getRedDays(2024);
      expect(redDays2024.any((h) => h.name == 'Julafton'), isFalse);
      expect(redDays2024.any((h) => h.name == 'Midsommardagen'), isTrue);
    });
  });

  group('Swedish Date Formatting & WeekNumber Tests', () {
    test('weekNumber calculates ISO-8601 week correctly', () {
      expect(DateTime(2024, 1, 1).weekNumber, 1);
      expect(DateTime(2024, 6, 21).weekNumber, 25);
    });

    test('Swedish weekday names format correctly', () {
      expect(DateTime(2024, 6, 21).weekdayNameSv, 'fredag');
      expect(DateTime(2024, 6, 21).weekdayNameShortSv, 'fre');
      expect(DateTime(2024, 6, 23).weekdayNameSv, 'söndag');
      expect(DateTime(2024, 6, 23).weekdayNameShortSv, 'sön');
    });

    test('Swedish month names format correctly', () {
      expect(DateTime(2024, 1, 15).monthNameSv, 'januari');
      expect(DateTime(2024, 1, 15).monthNameShortSv, 'jan');
      expect(DateTime(2024, 10, 31).monthNameSv, 'oktober');
      expect(DateTime(2024, 10, 31).monthNameShortSv, 'okt');
    });
  });

  group('Swedish Name Day Tests', () {
    test('getNameDay retrieves correct names for specific dates', () {
      final jan2 = AlmanacSv.getNameDay(DateTime(2024, 1, 2));
      expect(jan2.names, ['Svea']);

      final jan3 = AlmanacSv.getNameDay(DateTime(2024, 1, 3));
      expect(jan3.names, ['Alfred', 'Alfrida']);

      final dec24 = AlmanacSv.getNameDay(DateTime(2024, 12, 24));
      expect(dec24.names, ['Eva']);

      final jul25 = AlmanacSv.getNameDay(DateTime(2024, 12, 25));
      expect(jul25.names, isEmpty); // Juldagen has no name
    });

    test('getNameDaysForMonth returns all days for a month', () {
      final febNames = AlmanacSv.getNameDaysForMonth(2);
      expect(febNames.length, 29); // 29 entries in map
      expect(febNames.firstWhere((nd) => nd.day == 14).names, ['Valentin']);
    });
  });
}

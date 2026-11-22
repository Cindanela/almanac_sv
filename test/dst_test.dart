import 'package:almanac_sv/almanac_sv.dart';
import 'package:test/test.dart';

// These only fail on a machine whose time zone has DST, such as
// Europe/Stockholm: in UTC every local day is 24 hours.
void main() {
  test('holiday dates are midnight, even past a DST switch', () {
    for (var year = 2000; year <= 2050; year++) {
      for (final h in AlmanacSv.getAllHolidays(year)) {
        expect(
          h.date,
          DateTime(h.date.year, h.date.month, h.date.day),
          reason: '${h.name} $year',
        );
      }
    }
  });

  test('Alla helgons dag 2027 is Saturday 6 November', () {
    // 31 October 2027 is the autumn DST switch.
    final day = AlmanacSv.getAllHolidays(2027)
        .firstWhere((h) => h.name == 'Alla helgons dag');
    expect(day.date, DateTime(2027, 11, 6));
  });

  test('weekNumber is right on every day after the March switch', () {
    // 2026 starts on a Thursday, so every week's Thursday is a whole number
    // of weeks from 1 January and a 23-hour day would drop the week by one.
    expect(DateTime(2026, 4, 2).weekNumber, 14);
    for (var d = DateTime(2026); d.year < 2029;
        d = DateTime(d.year, d.month, d.day + 1)) {
      final monday = DateTime(d.year, d.month, d.day - (d.weekday - 1));
      expect(d.weekNumber, monday.weekNumber, reason: '$d');
    }
    expect(DateTime(2027).weekNumber, 53);
    expect(DateTime(2026, 12, 28).weekNumber, 53);
    expect(DateTime(2027, 1, 4).weekNumber, 1);
  });

  test('isDayBeforeRedDay looks at the next calendar day', () {
    // 25 October 2026 is the autumn DST switch; Monday the 26th is no red day.
    expect(AlmanacSv.isDayBeforeRedDay(DateTime(2026, 10, 25)), isFalse);
    expect(AlmanacSv.isDayBeforeRedDay(DateTime(2026, 12, 24)), isTrue);
  });
}

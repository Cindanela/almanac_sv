// ignore_for_file: avoid_print

import 'package:almanac_sv/almanac_sv.dart';

void main() {
  final now = DateTime.now();
  final year = now.year;

  print('=======================================');
  print('       SWEDISH ALMANAC $year           ');
  print('=======================================\n');

  print('Idag är det ${now.weekdayNameSv} den ${now.day} ${now.monthNameSv} $year (vecka ${now.weekNumber}).\n');

  // Check Name Day
  final nameDay = AlmanacSv.getNameDay(now);
  if (nameDay.names.isNotEmpty) {
    print('🎈 Dagens namnsdag: ${nameDay.names.join(", ")}');
  } else {
    print('🎈 Dagens namnsdag: Ingen namnsdag idag.');
  }

  // Check Holiday info
  final holidayInfo = AlmanacSv.getHolidayInfo(now);
  if (holidayInfo != null) {
    print('🌟 Idag är det: ${holidayInfo.name}');
    if (holidayInfo.isRedDay) print('🔴 Röd dag (helgdag)!');
    if (holidayInfo.isBankFreeDay) print('🔒 Bankfri dag (kontor och banker stängda).');
    if (holidayInfo.isFlagDay) print('🇸🇪 Flaggdag - hissa flaggan!');
  } else if (AlmanacSv.isRedDay(now)) {
    print('🔴 Idag är det en röd dag (söndag).');
  } else if (AlmanacSv.isDayBeforeRedDay(now)) {
    print('⏳ Imorgon är det röd dag! Kanske halvdag idag?');
  } else {
    print('📅 En helt vanlig arbetsdag.');
  }

  print('\n--- Kommande Röda Dagar $year ---');
  final redDays = AlmanacSv.getRedDays(year);
  for (var h in redDays.where((h) => h.date.isAfter(now) || h.date.isAtSameMomentAs(DateTime(now.year, now.month, now.day))).take(5)) {
    print('${h.date.toString().substring(0, 10)} (${h.date.weekdayNameShortSv}) - ${h.name}');
  }
}

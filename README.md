# almanac_sv

A comprehensive, zero-dependency Dart and Flutter package for the complete Swedish almanac. Calculate and retrieve Swedish public holidays (röda dagar), bank-free days (bankfria dagar), flag days (flaggdagar), name days (namnsdagar), Swedish weekday/month names, and ISO-8601 week numbers.

## Features

- **Public Holidays (Röda dagar)**: Get all official public holidays in Sweden, including dynamic calculations for Easter, Midsummer, and All Saints' Day.
- **Bank-free Days (Bankfria dagar)**: Retrieve days when banks and offices are closed (e.g. Christmas Eve, Midsummer Eve).
- **Flag Days (Flaggdagar)**: Identify all official Swedish flag days, including election years (Val till riksdagen).
- **Name Days (Namnsdagar)**: Complete 365-day database of official Swedish name days (*2001 års namnlängd*).
- **Swedish Date Formatting**: Intuitive `DateTime` extensions for Swedish weekday and month names (`måndag`, `januari`).
- **ISO Week Numbers**: Accurate ISO-8601 week calculation (`date.weekNumber`).

## Getting started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  almanac_sv: ^0.0.1
```

## Usage

Import the package:

```dart
import 'package:almanac_sv/almanac_sv.dart';
```

### 1. Holidays & Calendar Days

```dart
// Get all holidays for a year
final allHolidays = AlmanacSv.getAllHolidays(2024);
for (var holiday in allHolidays) {
  print('${holiday.date.toString().substring(0, 10)}: ${holiday.name}');
}

// Get official red days (Röda dagar)
final redDays = AlmanacSv.getRedDays(2024);

// Get bank-free days (Bankfria dagar) e.g. Christmas Eve
final bankFreeDays = AlmanacSv.getBankFreeDays(2024);
```

### 2. Swedish Name Days (Namnsdagar)

```dart
// Check who has a name day today
final today = DateTime.now();
final nameDay = AlmanacSv.getNameDay(today);

if (nameDay.names.isNotEmpty) {
  print('Grattis på namnsdagen: ${nameDay.names.join(", ")}!');
} else {
  print('Idag är det ingen vanlig namnsdag.');
}

// Get all name days for a specific month (e.g. July)
final julyNameDays = AlmanacSv.getNameDaysForMonth(7);
```

### 3. Swedish Date Formatting & Week Numbers

```dart
final today = DateTime(2024, 6, 21); // Friday in June

print('Idag är det ${today.weekdayNameSv}'); // "fredag"
print('Kort: ${today.weekdayNameShortSv}'); // "fre"

print('Månad: ${today.monthNameSv}'); // "juni"
print('Kort: ${today.monthNameShortSv}'); // "jun"

print('Vecka: ${today.weekNumber}'); // 25
```

### 4. Check a Specific Date

```dart
final date = DateTime(2024, 6, 6); // Nationaldagen
final info = AlmanacSv.getHolidayInfo(date);

if (info != null) {
  print('Helgdag: ${info.name}');
  if (info.isRedDay) print('Det är en röd dag!');
  if (info.isFlagDay) print('Kom ihåg att flagga!');
}
```

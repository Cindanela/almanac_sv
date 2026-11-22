## 0.0.4

* Pure Dart: dropped the unused Flutter SDK dependency, so Dart-only
  packages can depend on it. Tests use `package:test`, lints `package:lints`.

## 0.0.3

* Fixed dates computed across a DST switch in time zones such as Europe/Stockholm:
  * holiday offsets (e.g. Alla helgons dag 2027 came out as Friday 5 November 23:00);
  * `weekNumber`, one week low after the March switch in years starting on a Thursday (2026);
  * `isDayBeforeRedDay` on the day of the October switch.

## 0.0.2

* Updated dependencies and environment constraints for compatibility with Flutter 3.44.0.
* Ran `flutter pub upgrade` to resolve dependency conflicts and ensure smooth integration.

## 0.0.1

* Initial release of `almanac_sv` (superseding `holidays_sv`).
* Complete Swedish holiday calculations (röda dagar, flag days, bank-free days).
* Added Swedish name days (namnsdagar) lookup support.
* Added formatting extensions for Swedish weekday names and month names.
* Fully documented API with 100% pub.dev score.

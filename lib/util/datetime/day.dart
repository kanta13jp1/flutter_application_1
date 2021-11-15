import 'package:flutter_application_1/entity/weekday.dart';
import 'package:flutter_application_1/service/day.dart';

DateTime today() {
  return todayRepository.today();
}

DateTime now() {
  return todayRepository.now();
}

DateTime firstDayOfWeekday(DateTime day) {
  return day.subtract(Duration(days: day.weekday == 7 ? 0 : day.weekday));
}

DateTime endDayOfWeekday(DateTime day) {
  return day
      .subtract(Duration(days: day.weekday == 7 ? 0 : day.weekday))
      .add(Duration(days: Weekday.values.length - 1));
}

extension Date on DateTime {
  DateTime date() {
    return DateTime(year, month, day);
  }
}

// Reference: https://stackoverflow.com/questions/52713115/flutter-find-the-number-of-days-between-two-dates/67679455#67679455
int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

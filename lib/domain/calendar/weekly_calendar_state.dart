import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/organisms/calendar/band/calendar_band_model.dart';
import 'package:flutter_application_1/domain/calendar/date_range.dart';
import 'package:flutter_application_1/components/organisms/calendar/weekly/weekly_calendar_state.dart';
import 'package:flutter_application_1/entity/diary.dart';

class CalendarTabWeeklyCalendarState extends WeeklyCalendarState {
  final DateRange dateRange;
  final List<Diary> diariesForMonth;
  final List<CalendarBandModel> allBandModels;
  final DateTime targetDateOfMonth;

  CalendarTabWeeklyCalendarState({
    required this.dateRange,
    required this.diariesForMonth,
    required this.allBandModels,
    required this.targetDateOfMonth,
  });

  bool isGrayoutTile(DateTime date) => date.isPreviousMonth(targetDateOfMonth);
  bool hasDiaryMark(List<Diary> diaries, DateTime date) =>
      isExistsPostedDiary(diaries, date);
  bool hasMenstruationMark(DateTime date) => false;
  Alignment get contentAlignment => Alignment.center;
}

import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/components/molecules/shadow_container.dart';
import 'package:flutter_application_1/components/organisms/calendar/band/calendar_band_model.dart';
import 'package:flutter_application_1/components/organisms/calendar/monthly/monthly_calendar_layout.dart';
import 'package:flutter_application_1/components/organisms/calendar/weekly/weekly_calendar.dart';
import 'package:flutter_application_1/domain/calendar/calendar_card_state.dart';
import 'package:flutter_application_1/domain/calendar/weekly_calendar_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entity/diary.dart';

class CalendarCard extends StatelessWidget {
  final CalendarCardState state;
  final List<Diary> diariesForMonth;
  final List<CalendarBandModel> allBands;

  const CalendarCard({
    Key? key,
    required this.state,
    required this.diariesForMonth,
    required this.allBands,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: MonthlyCalendarLayout(
        state: state,
        weeklyCalendarBuilder: (context, weeklyDateRange) {
          return CalendarWeekdayLine(
            calendarState: CalendarTabWeeklyCalendarState(
              dateRange: weeklyDateRange,
              diariesForMonth: diariesForMonth,
              allBandModels: allBands,
              targetDateOfMonth: state.dateForMonth,
            ),
            horizontalPadding: 0,
            onTap: (weeklyCalendarState, date) {
              analytics.logEvent(name: "did_select_day_tile_on_calendar_card");
              transitionToPostDiary(context, date, diariesForMonth);
            },
          );
        },
      ),
    );
  }
}

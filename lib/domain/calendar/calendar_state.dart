import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_application_1/components/organisms/calendar/band/calendar_band_model.dart';
import 'package:flutter_application_1/components/organisms/calendar/utility.dart';
import 'package:flutter_application_1/entity/diary.dart';
import 'package:flutter_application_1/entity/menstruation.dart';
import 'package:flutter_application_1/entity/pill_sheet_group.dart';
import 'package:flutter_application_1/entity/pill_sheet_modified_history.dart';
import 'package:flutter_application_1/entity/setting.dart';
import 'package:flutter_application_1/util/datetime/date_compare.dart';
import 'package:flutter_application_1/util/datetime/day.dart';
import 'package:flutter_application_1/util/formatter/date_time_formatter.dart';

part 'calendar_state.freezed.dart';

@freezed
abstract class CalendarPageState implements _$CalendarPageState {
  CalendarPageState._();
  factory CalendarPageState({
    @Default(0) int currentCalendarIndex,
    @Default(true) bool isNotYetLoaded,
    @Default([]) List<Menstruation> menstruations,
    Setting? setting,
    PillSheetGroup? latestPillSheetGroup,
    @Default([]) List<Diary> diariesForMonth,
    @Default([]) List<PillSheetModifiedHistory> allPillSheetModifiedHistories,
    @Default(false) bool isPremium,
    @Default(false) bool isTrial,
    DateTime? trialDeadlineDate,
  }) = _CalendarPageState;

  bool get shouldShowIndicator => isNotYetLoaded || setting == null;

  final List<DateTime> calendarDataSource = _calendarDataSource();
  int get todayCalendarIndex => calendarDataSource
      .lastIndexWhere((element) => isSameMonth(element, today()));
  DateTime get displayMonth => calendarDataSource[currentCalendarIndex];
  String get displayMonthString => DateTimeFormatter.yearAndMonth(displayMonth);

  final _satisfyBandCount = 15;
  late final List<CalendarBandModel> allBands = buildBandModels(
    latestPillSheetGroup,
    setting,
    menstruations,
    _satisfyBandCount,
  );
}

List<DateTime> _calendarDataSource() {
  final base = today();
  return List.generate(24, (index) => (index + 1) - 12)
      .map((e) => DateTime(base.year, base.month + e, 1))
      .toList();
}

import 'dart:math';

import 'package:flutter_application_1/components/organisms/calendar/band/calendar_band_model.dart';
import 'package:flutter_application_1/domain/calendar/date_range.dart';
import 'package:flutter_application_1/entity/menstruation.dart';
import 'package:flutter_application_1/entity/pill_sheet_group.dart';
import 'package:flutter_application_1/entity/pill_sheet_type.dart';
import 'package:flutter_application_1/entity/setting.dart';
import 'package:flutter_application_1/entity/weekday.dart';
import 'package:flutter_application_1/util/datetime/date_compare.dart';

List<DateRange> scheduledOrInTheMiddleMenstruationDateRanges(
  PillSheetGroup pillSheetGroup,
  Setting setting,
  List<Menstruation> menstruations,
  int maxPageCount,
) {
  if (pillSheetGroup.pillSheets.isEmpty) {
    return [];
  }
  if (setting.pillNumberForFromMenstruation == 0) {
    return [];
  }
  assert(maxPageCount > 0);

  final totalPillCount = pillSheetGroup.pillSheets
      .map((e) => e.pillSheetType.totalCount)
      .reduce((value, element) => value + element);
  final List<DateRange> dateRanges = [];
  // 大体の数を計算
  for (int i = 0; i < maxPageCount; i++) {
    final offset = totalPillCount * i;
    for (int pageIndex = 0;
        pageIndex < pillSheetGroup.pillSheets.length;
        pageIndex++) {
      final pillSheet = pillSheetGroup.pillSheets[pageIndex];
      final pillSheetTypes =
          pillSheetGroup.pillSheets.map((e) => e.pillSheetType).toList();
      final passedCount = summarizedPillSheetTypeTotalCountToPageIndex(
          pillSheetTypes: pillSheetTypes, pageIndex: pageIndex);
      final serializedTotalPillNumber =
          passedCount + pillSheet.typeInfo.totalCount;
      if (serializedTotalPillNumber < setting.pillNumberForFromMenstruation) {
        continue;
      }

      final int menstruationNumber;
      if (passedCount == 0) {
        menstruationNumber = setting.pillNumberForFromMenstruation;
      } else {
        menstruationNumber =
            setting.pillNumberForFromMenstruation % passedCount;
      }

      if (menstruationNumber > pillSheet.pillSheetType.totalCount) {
        continue;
      }

      final begin = pillSheet.beginingDate
          .add(Duration(days: (menstruationNumber - 1) + offset));
      final end = begin.add(Duration(days: (setting.durationMenstruation - 1)));
      final isRealMenstruationDurationContained = menstruations
          .where((element) =>
              element.dateRange.inRange(begin) ||
              element.dateRange.inRange(end))
          .isNotEmpty;
      if (isRealMenstruationDurationContained) {
        continue;
      }
      final isAlreadyContained = dateRanges
          .where((element) =>
              isSameDay(element.begin, begin) || isSameDay(element.end, end))
          .isNotEmpty;
      if (isAlreadyContained) {
        continue;
      }

      dateRanges.add(DateRange(begin, end));
      if (dateRanges.length >= maxPageCount) {
        return dateRanges;
      }
    }
  }
  return dateRanges;
}

List<DateRange> nextPillSheetDateRanges(
  PillSheetGroup pillSheetGroup,
  int maxPageCount,
) {
  if (pillSheetGroup.pillSheets.isEmpty) {
    return [];
  }
  assert(maxPageCount > 0);

  // 大体の数を計算
  final totalPillCount = pillSheetGroup.pillSheets
      .map((e) => e.pillSheetType.totalCount)
      .reduce((value, element) => value + element);
  final count = max(maxPageCount, pillSheetGroup.pillSheets.length) /
      pillSheetGroup.pillSheets.length;
  return List.generate(count.toInt(), (groupPageIndex) {
    return pillSheetGroup.pillSheets.map((pillSheet) {
      final offset = groupPageIndex * totalPillCount;
      final begin = pillSheet.estimatedLastTakenDate.add(Duration(days: 1));
      final end = begin.add(Duration(days: Weekday.values.length - 1));
      return DateRange(
          begin.add(Duration(days: offset)), end.add(Duration(days: offset)));
    });
  }).expand((element) => element).toList();
}

int bandLength(
    DateRange range, CalendarBandModel bandModel, bool isLineBreaked) {
  return range
          .union(
            DateRange(
              isLineBreaked ? range.begin : bandModel.begin,
              bandModel.end,
            ),
          )
          .days +
      1;
}

List<CalendarBandModel> buildBandModels(
  PillSheetGroup? pillSheetGroup,
  Setting? setting,
  List<Menstruation> menstruations,
  int maxPageCount,
) {
  assert(maxPageCount > 0);
  return [
    ...menstruations.map((e) => CalendarMenstruationBandModel(e)),
    if (pillSheetGroup != null) ...[
      ...scheduledOrInTheMiddleMenstruationDateRanges(
              pillSheetGroup, setting!, menstruations, maxPageCount)
          .where((bandRange) => menstruations
              .where((menstruation) =>
                  bandRange.inRange(menstruation.beginDate) ||
                  bandRange.inRange(menstruation.endDate))
              .isEmpty)
          .map((range) =>
              CalendarScheduledMenstruationBandModel(range.begin, range.end)),
      ...nextPillSheetDateRanges(pillSheetGroup, maxPageCount).map(
          (range) => CalendarNextPillSheetBandModel(range.begin, range.end))
    ]
  ];
}

import 'package:flutter_application_1/domain/calendar/date_range.dart';
import 'package:flutter_application_1/entity/firestore_timestamp_converter.dart';
import 'package:flutter_application_1/entity/pill_sheet_type.dart';
import 'package:flutter_application_1/util/datetime/day.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pill_sheet.g.dart';
part 'pill_sheet.freezed.dart';

abstract class PillSheetFirestoreKey {
  static final String typeInfo = "typeInfo";
  static final String createdAt = "createdAt";
  static final String deletedAt = "deletedAt";
  static final String lastTakenDate = "lastTakenDate";
  static final String beginingDate = "beginingDate";
}

@freezed
abstract class PillSheetTypeInfo with _$PillSheetTypeInfo {
  @JsonSerializable(explicitToJson: true)
  factory PillSheetTypeInfo({
    required String pillSheetTypeReferencePath,
    required String name,
    required int totalCount,
    required int dosingPeriod,
  }) = _PillSheetTypeInfo;

  factory PillSheetTypeInfo.fromJson(Map<String, dynamic> json) =>
      _$PillSheetTypeInfoFromJson(json);
  Map<String, dynamic> toJson() =>
      _$_$_PillSheetTypeInfoToJson(this as _$_PillSheetTypeInfo);
}

@freezed
abstract class RestDuration with _$RestDuration {
  @JsonSerializable(explicitToJson: true)
  factory RestDuration({
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime beginDate,
    @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp,
    )
        DateTime? endDate,
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime createdDate,
  }) = _RestDuration;

  factory RestDuration.fromJson(Map<String, dynamic> json) =>
      _$RestDurationFromJson(json);
  Map<String, dynamic> toJson() =>
      _$_$_RestDurationToJson(this as _$_RestDuration);
}

@freezed
abstract class PillSheet implements _$PillSheet {
  String? get documentID => id;

  PillSheetType get sheetType =>
      PillSheetTypeFunctions.fromRawPath(typeInfo.pillSheetTypeReferencePath);

  PillSheet._();
  @JsonSerializable(explicitToJson: true)
  factory PillSheet({
    @JsonKey(includeIfNull: false)
        String? id,
    @JsonKey()
        required PillSheetTypeInfo typeInfo,
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime beginingDate,
    @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp,
    )
        DateTime? lastTakenDate,
    @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp,
    )
        DateTime? createdAt,
    @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp,
    )
        DateTime? deletedAt,
    @Default(0)
        int groupIndex,
    @Default([])
        List<RestDuration> restDurations,
  }) = _PillSheet;
  factory PillSheet.create(PillSheetType type) => PillSheet(
        typeInfo: type.typeInfo,
        beginingDate: today(),
        lastTakenDate: null,
      );

  factory PillSheet.fromJson(Map<String, dynamic> json) =>
      _$PillSheetFromJson(json);
  Map<String, dynamic> toJson() => _$_$_PillSheetToJson(this as _$_PillSheet);

  PillSheetType get pillSheetType =>
      PillSheetTypeFunctions.fromRawPath(typeInfo.pillSheetTypeReferencePath);

  int get todayPillNumber {
    return daysBetween(beginingDate.date(), today()) -
        summarizedRestDuration(restDurations) +
        1;
  }

  int get lastTakenPillNumber {
    final lastTakenDate = this.lastTakenDate;
    if (lastTakenDate == null) {
      return 0;
    }

    final lastTakenPillNumber =
        daysBetween(beginingDate.date(), lastTakenDate.date()) + 1;
    if (restDurations.isEmpty) {
      return lastTakenPillNumber;
    }

    final summarizedRestDuration = restDurations.map((e) {
      if (!e.beginDate.isBefore(lastTakenDate)) {
        return 0;
      }
      final endDate = e.endDate;
      if (endDate == null) {
        return daysBetween(e.beginDate, today());
      } else if (lastTakenDate.isAfter(e.beginDate)) {
        return daysBetween(e.beginDate, endDate);
      } else {
        return 0;
      }
    }).reduce((value, element) => value + element);

    return lastTakenPillNumber - summarizedRestDuration;
  }

  bool get isAllTaken => todayPillNumber == lastTakenPillNumber;
  bool get isEnded => typeInfo.totalCount == lastTakenPillNumber;
  bool get isReached =>
      beginingDate.date().toUtc().millisecondsSinceEpoch <
      now().toUtc().millisecondsSinceEpoch;
  bool get inNotTakenDuration => todayPillNumber > typeInfo.dosingPeriod;
  bool get pillSheetHasRestOrFakeDuration =>
      !pillSheetType.isNotExistsNotTakenDuration;
  bool get isActive {
    final n = now();
    final begin = beginingDate.date();
    final totalCount = typeInfo.totalCount;
    final end = begin.add(
        Duration(days: totalCount + summarizedRestDuration(restDurations) - 1));
    return DateRange(begin, end).inRange(n);
  }

  DateTime get estimatedLastTakenDate => beginingDate
      .add(Duration(days: pillSheetType.totalCount - 1))
      .add(Duration(days: summarizedRestDuration(restDurations)))
      .date()
      .add(Duration(days: 1))
      .subtract(Duration(seconds: 1));

  RestDuration? get activeRestDuration {
    if (restDurations.isEmpty) {
      return null;
    } else {
      if (restDurations.last.endDate == null &&
          restDurations.last.beginDate.isBefore(now())) {
        return restDurations.last;
      } else {
        return null;
      }
    }
  }
}

int summarizedRestDuration(List<RestDuration> restDurations) {
  if (restDurations.isEmpty) {
    return 0;
  }
  return restDurations.map((e) {
    final endDate = e.endDate;
    if (endDate == null) {
      return daysBetween(e.beginDate, today());
    } else {
      return daysBetween(e.beginDate, endDate);
    }
  }).reduce((value, element) => value + element);
}

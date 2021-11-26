// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pill_sheet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PillSheetTypeInfo _$PillSheetTypeInfoFromJson(Map<String, dynamic> json) {
  return _PillSheetTypeInfo.fromJson(json);
}

/// @nodoc
class _$PillSheetTypeInfoTearOff {
  const _$PillSheetTypeInfoTearOff();

  _PillSheetTypeInfo call(
      {required String pillSheetTypeReferencePath,
      required String name,
      required int totalCount,
      required int dosingPeriod}) {
    return _PillSheetTypeInfo(
      pillSheetTypeReferencePath: pillSheetTypeReferencePath,
      name: name,
      totalCount: totalCount,
      dosingPeriod: dosingPeriod,
    );
  }

  PillSheetTypeInfo fromJson(Map<String, Object?> json) {
    return PillSheetTypeInfo.fromJson(json);
  }
}

/// @nodoc
const $PillSheetTypeInfo = _$PillSheetTypeInfoTearOff();

/// @nodoc
mixin _$PillSheetTypeInfo {
  String get pillSheetTypeReferencePath => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int get dosingPeriod => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PillSheetTypeInfoCopyWith<PillSheetTypeInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PillSheetTypeInfoCopyWith<$Res> {
  factory $PillSheetTypeInfoCopyWith(
          PillSheetTypeInfo value, $Res Function(PillSheetTypeInfo) then) =
      _$PillSheetTypeInfoCopyWithImpl<$Res>;
  $Res call(
      {String pillSheetTypeReferencePath,
      String name,
      int totalCount,
      int dosingPeriod});
}

/// @nodoc
class _$PillSheetTypeInfoCopyWithImpl<$Res>
    implements $PillSheetTypeInfoCopyWith<$Res> {
  _$PillSheetTypeInfoCopyWithImpl(this._value, this._then);

  final PillSheetTypeInfo _value;
  // ignore: unused_field
  final $Res Function(PillSheetTypeInfo) _then;

  @override
  $Res call({
    Object? pillSheetTypeReferencePath = freezed,
    Object? name = freezed,
    Object? totalCount = freezed,
    Object? dosingPeriod = freezed,
  }) {
    return _then(_value.copyWith(
      pillSheetTypeReferencePath: pillSheetTypeReferencePath == freezed
          ? _value.pillSheetTypeReferencePath
          : pillSheetTypeReferencePath // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      dosingPeriod: dosingPeriod == freezed
          ? _value.dosingPeriod
          : dosingPeriod // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$PillSheetTypeInfoCopyWith<$Res>
    implements $PillSheetTypeInfoCopyWith<$Res> {
  factory _$PillSheetTypeInfoCopyWith(
          _PillSheetTypeInfo value, $Res Function(_PillSheetTypeInfo) then) =
      __$PillSheetTypeInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String pillSheetTypeReferencePath,
      String name,
      int totalCount,
      int dosingPeriod});
}

/// @nodoc
class __$PillSheetTypeInfoCopyWithImpl<$Res>
    extends _$PillSheetTypeInfoCopyWithImpl<$Res>
    implements _$PillSheetTypeInfoCopyWith<$Res> {
  __$PillSheetTypeInfoCopyWithImpl(
      _PillSheetTypeInfo _value, $Res Function(_PillSheetTypeInfo) _then)
      : super(_value, (v) => _then(v as _PillSheetTypeInfo));

  @override
  _PillSheetTypeInfo get _value => super._value as _PillSheetTypeInfo;

  @override
  $Res call({
    Object? pillSheetTypeReferencePath = freezed,
    Object? name = freezed,
    Object? totalCount = freezed,
    Object? dosingPeriod = freezed,
  }) {
    return _then(_PillSheetTypeInfo(
      pillSheetTypeReferencePath: pillSheetTypeReferencePath == freezed
          ? _value.pillSheetTypeReferencePath
          : pillSheetTypeReferencePath // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      dosingPeriod: dosingPeriod == freezed
          ? _value.dosingPeriod
          : dosingPeriod // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_PillSheetTypeInfo implements _PillSheetTypeInfo {
  _$_PillSheetTypeInfo(
      {required this.pillSheetTypeReferencePath,
      required this.name,
      required this.totalCount,
      required this.dosingPeriod});

  factory _$_PillSheetTypeInfo.fromJson(Map<String, dynamic> json) =>
      _$$_PillSheetTypeInfoFromJson(json);

  @override
  final String pillSheetTypeReferencePath;
  @override
  final String name;
  @override
  final int totalCount;
  @override
  final int dosingPeriod;

  @override
  String toString() {
    return 'PillSheetTypeInfo(pillSheetTypeReferencePath: $pillSheetTypeReferencePath, name: $name, totalCount: $totalCount, dosingPeriod: $dosingPeriod)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PillSheetTypeInfo &&
            (identical(other.pillSheetTypeReferencePath,
                    pillSheetTypeReferencePath) ||
                other.pillSheetTypeReferencePath ==
                    pillSheetTypeReferencePath) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.dosingPeriod, dosingPeriod) ||
                other.dosingPeriod == dosingPeriod));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, pillSheetTypeReferencePath, name, totalCount, dosingPeriod);

  @JsonKey(ignore: true)
  @override
  _$PillSheetTypeInfoCopyWith<_PillSheetTypeInfo> get copyWith =>
      __$PillSheetTypeInfoCopyWithImpl<_PillSheetTypeInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PillSheetTypeInfoToJson(this);
  }
}

abstract class _PillSheetTypeInfo implements PillSheetTypeInfo {
  factory _PillSheetTypeInfo(
      {required String pillSheetTypeReferencePath,
      required String name,
      required int totalCount,
      required int dosingPeriod}) = _$_PillSheetTypeInfo;

  factory _PillSheetTypeInfo.fromJson(Map<String, dynamic> json) =
      _$_PillSheetTypeInfo.fromJson;

  @override
  String get pillSheetTypeReferencePath;
  @override
  String get name;
  @override
  int get totalCount;
  @override
  int get dosingPeriod;
  @override
  @JsonKey(ignore: true)
  _$PillSheetTypeInfoCopyWith<_PillSheetTypeInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

RestDuration _$RestDurationFromJson(Map<String, dynamic> json) {
  return _RestDuration.fromJson(json);
}

/// @nodoc
class _$RestDurationTearOff {
  const _$RestDurationTearOff();

  _RestDuration call(
      {@JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime beginDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? endDate,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime createdDate}) {
    return _RestDuration(
      beginDate: beginDate,
      endDate: endDate,
      createdDate: createdDate,
    );
  }

  RestDuration fromJson(Map<String, Object?> json) {
    return RestDuration.fromJson(json);
  }
}

/// @nodoc
const $RestDuration = _$RestDurationTearOff();

/// @nodoc
mixin _$RestDuration {
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get beginDate => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  DateTime? get endDate => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get createdDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestDurationCopyWith<RestDuration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestDurationCopyWith<$Res> {
  factory $RestDurationCopyWith(
          RestDuration value, $Res Function(RestDuration) then) =
      _$RestDurationCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime beginDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? endDate,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime createdDate});
}

/// @nodoc
class _$RestDurationCopyWithImpl<$Res> implements $RestDurationCopyWith<$Res> {
  _$RestDurationCopyWithImpl(this._value, this._then);

  final RestDuration _value;
  // ignore: unused_field
  final $Res Function(RestDuration) _then;

  @override
  $Res call({
    Object? beginDate = freezed,
    Object? endDate = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(_value.copyWith(
      beginDate: beginDate == freezed
          ? _value.beginDate
          : beginDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdDate: createdDate == freezed
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$RestDurationCopyWith<$Res>
    implements $RestDurationCopyWith<$Res> {
  factory _$RestDurationCopyWith(
          _RestDuration value, $Res Function(_RestDuration) then) =
      __$RestDurationCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime beginDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? endDate,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime createdDate});
}

/// @nodoc
class __$RestDurationCopyWithImpl<$Res> extends _$RestDurationCopyWithImpl<$Res>
    implements _$RestDurationCopyWith<$Res> {
  __$RestDurationCopyWithImpl(
      _RestDuration _value, $Res Function(_RestDuration) _then)
      : super(_value, (v) => _then(v as _RestDuration));

  @override
  _RestDuration get _value => super._value as _RestDuration;

  @override
  $Res call({
    Object? beginDate = freezed,
    Object? endDate = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(_RestDuration(
      beginDate: beginDate == freezed
          ? _value.beginDate
          : beginDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdDate: createdDate == freezed
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_RestDuration implements _RestDuration {
  _$_RestDuration(
      {@JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required this.beginDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          this.endDate,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required this.createdDate});

  factory _$_RestDuration.fromJson(Map<String, dynamic> json) =>
      _$$_RestDurationFromJson(json);

  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  final DateTime beginDate;
  @override
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  final DateTime? endDate;
  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  final DateTime createdDate;

  @override
  String toString() {
    return 'RestDuration(beginDate: $beginDate, endDate: $endDate, createdDate: $createdDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RestDuration &&
            (identical(other.beginDate, beginDate) ||
                other.beginDate == beginDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, beginDate, endDate, createdDate);

  @JsonKey(ignore: true)
  @override
  _$RestDurationCopyWith<_RestDuration> get copyWith =>
      __$RestDurationCopyWithImpl<_RestDuration>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RestDurationToJson(this);
  }
}

abstract class _RestDuration implements RestDuration {
  factory _RestDuration(
      {@JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime beginDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? endDate,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime createdDate}) = _$_RestDuration;

  factory _RestDuration.fromJson(Map<String, dynamic> json) =
      _$_RestDuration.fromJson;

  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get beginDate;
  @override
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  DateTime? get endDate;
  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get createdDate;
  @override
  @JsonKey(ignore: true)
  _$RestDurationCopyWith<_RestDuration> get copyWith =>
      throw _privateConstructorUsedError;
}

PillSheet _$PillSheetFromJson(Map<String, dynamic> json) {
  return _PillSheet.fromJson(json);
}

/// @nodoc
class _$PillSheetTearOff {
  const _$PillSheetTearOff();

  _PillSheet call(
      {@JsonKey(includeIfNull: false)
          String? id,
      @JsonKey()
          required PillSheetTypeInfo typeInfo,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime beginingDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? lastTakenDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? createdAt,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? deletedAt,
      int groupIndex = 0,
      List<RestDuration> restDurations = const []}) {
    return _PillSheet(
      id: id,
      typeInfo: typeInfo,
      beginingDate: beginingDate,
      lastTakenDate: lastTakenDate,
      createdAt: createdAt,
      deletedAt: deletedAt,
      groupIndex: groupIndex,
      restDurations: restDurations,
    );
  }

  PillSheet fromJson(Map<String, Object?> json) {
    return PillSheet.fromJson(json);
  }
}

/// @nodoc
const $PillSheet = _$PillSheetTearOff();

/// @nodoc
mixin _$PillSheet {
  @JsonKey(includeIfNull: false)
  String? get id => throw _privateConstructorUsedError;
  @JsonKey()
  PillSheetTypeInfo get typeInfo => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get beginingDate => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  DateTime? get lastTakenDate => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  int get groupIndex => throw _privateConstructorUsedError;
  List<RestDuration> get restDurations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PillSheetCopyWith<PillSheet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PillSheetCopyWith<$Res> {
  factory $PillSheetCopyWith(PillSheet value, $Res Function(PillSheet) then) =
      _$PillSheetCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(includeIfNull: false)
          String? id,
      @JsonKey()
          PillSheetTypeInfo typeInfo,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime beginingDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? lastTakenDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? createdAt,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? deletedAt,
      int groupIndex,
      List<RestDuration> restDurations});

  $PillSheetTypeInfoCopyWith<$Res> get typeInfo;
}

/// @nodoc
class _$PillSheetCopyWithImpl<$Res> implements $PillSheetCopyWith<$Res> {
  _$PillSheetCopyWithImpl(this._value, this._then);

  final PillSheet _value;
  // ignore: unused_field
  final $Res Function(PillSheet) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? typeInfo = freezed,
    Object? beginingDate = freezed,
    Object? lastTakenDate = freezed,
    Object? createdAt = freezed,
    Object? deletedAt = freezed,
    Object? groupIndex = freezed,
    Object? restDurations = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      typeInfo: typeInfo == freezed
          ? _value.typeInfo
          : typeInfo // ignore: cast_nullable_to_non_nullable
              as PillSheetTypeInfo,
      beginingDate: beginingDate == freezed
          ? _value.beginingDate
          : beginingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastTakenDate: lastTakenDate == freezed
          ? _value.lastTakenDate
          : lastTakenDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: deletedAt == freezed
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      groupIndex: groupIndex == freezed
          ? _value.groupIndex
          : groupIndex // ignore: cast_nullable_to_non_nullable
              as int,
      restDurations: restDurations == freezed
          ? _value.restDurations
          : restDurations // ignore: cast_nullable_to_non_nullable
              as List<RestDuration>,
    ));
  }

  @override
  $PillSheetTypeInfoCopyWith<$Res> get typeInfo {
    return $PillSheetTypeInfoCopyWith<$Res>(_value.typeInfo, (value) {
      return _then(_value.copyWith(typeInfo: value));
    });
  }
}

/// @nodoc
abstract class _$PillSheetCopyWith<$Res> implements $PillSheetCopyWith<$Res> {
  factory _$PillSheetCopyWith(
          _PillSheet value, $Res Function(_PillSheet) then) =
      __$PillSheetCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(includeIfNull: false)
          String? id,
      @JsonKey()
          PillSheetTypeInfo typeInfo,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime beginingDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? lastTakenDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? createdAt,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? deletedAt,
      int groupIndex,
      List<RestDuration> restDurations});

  @override
  $PillSheetTypeInfoCopyWith<$Res> get typeInfo;
}

/// @nodoc
class __$PillSheetCopyWithImpl<$Res> extends _$PillSheetCopyWithImpl<$Res>
    implements _$PillSheetCopyWith<$Res> {
  __$PillSheetCopyWithImpl(_PillSheet _value, $Res Function(_PillSheet) _then)
      : super(_value, (v) => _then(v as _PillSheet));

  @override
  _PillSheet get _value => super._value as _PillSheet;

  @override
  $Res call({
    Object? id = freezed,
    Object? typeInfo = freezed,
    Object? beginingDate = freezed,
    Object? lastTakenDate = freezed,
    Object? createdAt = freezed,
    Object? deletedAt = freezed,
    Object? groupIndex = freezed,
    Object? restDurations = freezed,
  }) {
    return _then(_PillSheet(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      typeInfo: typeInfo == freezed
          ? _value.typeInfo
          : typeInfo // ignore: cast_nullable_to_non_nullable
              as PillSheetTypeInfo,
      beginingDate: beginingDate == freezed
          ? _value.beginingDate
          : beginingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastTakenDate: lastTakenDate == freezed
          ? _value.lastTakenDate
          : lastTakenDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: deletedAt == freezed
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      groupIndex: groupIndex == freezed
          ? _value.groupIndex
          : groupIndex // ignore: cast_nullable_to_non_nullable
              as int,
      restDurations: restDurations == freezed
          ? _value.restDurations
          : restDurations // ignore: cast_nullable_to_non_nullable
              as List<RestDuration>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_PillSheet extends _PillSheet {
  _$_PillSheet(
      {@JsonKey(includeIfNull: false)
          this.id,
      @JsonKey()
          required this.typeInfo,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required this.beginingDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          this.lastTakenDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          this.createdAt,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          this.deletedAt,
      this.groupIndex = 0,
      this.restDurations = const []})
      : super._();

  factory _$_PillSheet.fromJson(Map<String, dynamic> json) =>
      _$$_PillSheetFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final String? id;
  @override
  @JsonKey()
  final PillSheetTypeInfo typeInfo;
  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  final DateTime beginingDate;
  @override
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  final DateTime? lastTakenDate;
  @override
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  final DateTime? createdAt;
  @override
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  final DateTime? deletedAt;
  @JsonKey(defaultValue: 0)
  @override
  final int groupIndex;
  @JsonKey(defaultValue: const [])
  @override
  final List<RestDuration> restDurations;

  @override
  String toString() {
    return 'PillSheet(id: $id, typeInfo: $typeInfo, beginingDate: $beginingDate, lastTakenDate: $lastTakenDate, createdAt: $createdAt, deletedAt: $deletedAt, groupIndex: $groupIndex, restDurations: $restDurations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PillSheet &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.typeInfo, typeInfo) ||
                other.typeInfo == typeInfo) &&
            (identical(other.beginingDate, beginingDate) ||
                other.beginingDate == beginingDate) &&
            (identical(other.lastTakenDate, lastTakenDate) ||
                other.lastTakenDate == lastTakenDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.groupIndex, groupIndex) ||
                other.groupIndex == groupIndex) &&
            const DeepCollectionEquality()
                .equals(other.restDurations, restDurations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      typeInfo,
      beginingDate,
      lastTakenDate,
      createdAt,
      deletedAt,
      groupIndex,
      const DeepCollectionEquality().hash(restDurations));

  @JsonKey(ignore: true)
  @override
  _$PillSheetCopyWith<_PillSheet> get copyWith =>
      __$PillSheetCopyWithImpl<_PillSheet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PillSheetToJson(this);
  }
}

abstract class _PillSheet extends PillSheet {
  factory _PillSheet(
      {@JsonKey(includeIfNull: false)
          String? id,
      @JsonKey()
          required PillSheetTypeInfo typeInfo,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime beginingDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? lastTakenDate,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? createdAt,
      @JsonKey(fromJson: TimestampConverter.timestampToDateTime, toJson: TimestampConverter.dateTimeToTimestamp)
          DateTime? deletedAt,
      int groupIndex,
      List<RestDuration> restDurations}) = _$_PillSheet;
  _PillSheet._() : super._();

  factory _PillSheet.fromJson(Map<String, dynamic> json) =
      _$_PillSheet.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  String? get id;
  @override
  @JsonKey()
  PillSheetTypeInfo get typeInfo;
  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get beginingDate;
  @override
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  DateTime? get lastTakenDate;
  @override
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  DateTime? get createdAt;
  @override
  @JsonKey(
      fromJson: TimestampConverter.timestampToDateTime,
      toJson: TimestampConverter.dateTimeToTimestamp)
  DateTime? get deletedAt;
  @override
  int get groupIndex;
  @override
  List<RestDuration> get restDurations;
  @override
  @JsonKey(ignore: true)
  _$PillSheetCopyWith<_PillSheet> get copyWith =>
      throw _privateConstructorUsedError;
}

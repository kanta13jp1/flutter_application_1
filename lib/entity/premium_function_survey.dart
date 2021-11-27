import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_application_1/domain/premium_function_survey/premium_function_survey_element_type.dart';

part 'premium_function_survey.g.dart';
part 'premium_function_survey.freezed.dart';

@freezed
abstract class PremiumFunctionSurvey with _$PremiumFunctionSurvey {
  @JsonSerializable(explicitToJson: true)
  factory PremiumFunctionSurvey({
    required List<PremiumFunctionSurveyElementType> elements,
    required String message,
  }) = _PremiumFunctionSurvey;
  PremiumFunctionSurvey._();
  factory PremiumFunctionSurvey.fromJson(Map<String, dynamic> json) =>
      _$PremiumFunctionSurveyFromJson(json);
  Map<String, dynamic> toJson() =>
      _$$_PremiumFunctionSurveyToJson(this as _$_PremiumFunctionSurvey);
}

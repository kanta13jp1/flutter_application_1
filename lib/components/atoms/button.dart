import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter/material.dart';

abstract class ButtonTextStyle {
  static final TextStyle main = TextStyle(
    fontFamily: FontFamily.japanese,
    fontWeight: FontWeight.w700,
    fontSize: FontSize.sLarge,
    color: PilllColors.white,
  );
  static final TextStyle alert = TextStyle(
    fontFamily: FontFamily.japanese,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.normal,
    color: PilllColors.primary,
  );
}

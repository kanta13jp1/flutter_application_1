import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/entity/weekday.dart';
import 'package:flutter/material.dart';

abstract class WeekdayBadgeConst {
  static final double height = 30;
}

class WeekdayBadge extends StatelessWidget {
  final Weekday weekday;
  const WeekdayBadge({
    Key? key,
    required this.weekday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: WeekdayBadgeConst.height,
      color: PilllColors.white,
      child: Center(
        child: Text(weekday.weekdayString(),
            textAlign: TextAlign.end,
            style: FontType.sSmallTitle
                .merge(TextStyle(color: weekday.weekdayColor()))),
      ),
    );
  }
}

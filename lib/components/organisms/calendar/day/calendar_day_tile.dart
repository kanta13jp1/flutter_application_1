import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/components/organisms/calendar/monthly/monthly_calendar_layout.dart';
import 'package:flutter_application_1/entity/weekday.dart';

class CalendarDayTile extends StatelessWidget {
  final DateTime date;
  final Weekday weekday;
  final bool isToday;
  final bool shouldShowDiaryMark;
  final bool shouldShowMenstruationMark;
  final Alignment contentAlignment;
  final Function(DateTime)? onTap;

  const CalendarDayTile.grayout({
    required DateTime date,
    required Weekday weekday,
    required bool shouldShowMenstruationMark,
    required Alignment contentAlignment,
  }) : this(
          isToday: false,
          onTap: null,
          weekday: weekday,
          shouldShowDiaryMark: false,
          shouldShowMenstruationMark: shouldShowMenstruationMark,
          contentAlignment: contentAlignment,
          date: date,
        );

  const CalendarDayTile({
    Key? key,
    required this.date,
    required this.weekday,
    required this.isToday,
    required this.shouldShowDiaryMark,
    required this.shouldShowMenstruationMark,
    required this.contentAlignment,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onTap = this.onTap;
    return Expanded(
      child: RawMaterialButton(
        onPressed: () => onTap != null ? onTap(date) : null,
        child: Container(
          height: CalendarConstants.tileHeight,
          child: Stack(
            children: <Widget>[
              if (shouldShowDiaryMark) ...[
                Positioned.fill(
                  top: 8,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: _diaryMarkWidget()),
                )
              ],
              Positioned(
                child: Align(
                  alignment: contentAlignment,
                  child: _content(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      width: 40,
      height: 40,
      child: Stack(
        children: [
          if (shouldShowMenstruationMark)
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: PilllColors.menstruation,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          if (isToday)
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: PilllColors.secondary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          Positioned(
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${date.day}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _textColor()).merge(_font()),
                )),
          ),
        ],
      ),
    );
  }

  TextStyle _font() {
    return FontType.gridElement;
  }

  Color _textColor() {
    if (isToday) {
      return PilllColors.white;
    }
    final weekdayColor = () {
      switch (weekday) {
        case Weekday.Sunday:
          return weekday.weekdayColor();
        case Weekday.Monday:
          return TextColor.main;
        case Weekday.Tuesday:
          return TextColor.main;
        case Weekday.Wednesday:
          return TextColor.main;
        case Weekday.Thursday:
          return TextColor.main;
        case Weekday.Friday:
          return TextColor.main;
        case Weekday.Saturday:
          return weekday.weekdayColor();
      }
    }();
    final onTap = this.onTap;
    final alpha = (255 * (onTap != null ? 1 : 0.4)).floor();
    return weekdayColor.withAlpha(alpha);
  }

  Widget _diaryMarkWidget() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
          color: PilllColors.gray, borderRadius: BorderRadius.circular(4)),
    );
  }
}

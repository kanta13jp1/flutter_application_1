import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/domain/calendar/components/pill_sheet_modified_history/components/pill_sheet_modified_history_date_component.dart';
import 'package:flutter_application_1/domain/calendar/components/pill_sheet_modified_history/components/taken_pill_action_o_list.dart';
import 'package:flutter_application_1/entity/pill_sheet.dart';
import 'package:flutter_application_1/entity/pill_sheet_modified_history_value.dart';
import 'package:flutter_application_1/util/formatter/date_time_formatter.dart';

class PillSheetModifiedHistoryTakenPillAction extends StatelessWidget {
  final DateTime estimatedEventCausingDate;
  final TakenPillValue? value;
  final PillSheet? beforePillSheet;
  final PillSheet? afterPillSheet;

  const PillSheetModifiedHistoryTakenPillAction({
    Key? key,
    required this.estimatedEventCausingDate,
    required this.value,
    required this.beforePillSheet,
    required this.afterPillSheet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = this.value;
    final beforePillSheet = this.beforePillSheet;
    final afterPillSheet = this.afterPillSheet;
    if (value == null || afterPillSheet == null || beforePillSheet == null) {
      return Container();
    }
    final time = DateTimeFormatter.hourAndMinute(estimatedEventCausingDate);
    return GestureDetector(
      onTap: () {
        analytics.logEvent(name: "tapped_history_taken_action");
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: Row(
            children: [
              PillSheetModifiedHistoryDate(
                estimatedEventCausingDate: estimatedEventCausingDate,
                effectivePillNumber:
                    PillSheetModifiedHistoryDateEffectivePillNumber.taken(
                        value),
              ),
              Spacer(),
              Container(
                constraints: BoxConstraints(
                  maxWidth:
                      PillSheetModifiedHistoryTakenActionLayoutWidths.trailing,
                ),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        time,
                        style: TextStyle(
                          letterSpacing: 1.5,
                          color: TextColor.main,
                          fontSize: 15,
                          fontFamily: FontFamily.number,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: PillSheetModifiedHistoryTakenActionLayoutWidths
                          .takenMark,
                      padding: EdgeInsets.only(left: 8),
                      child: TakenPillActionOList(
                        value: value,
                        beforePillSheet: beforePillSheet,
                        afterPillSheet: afterPillSheet,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

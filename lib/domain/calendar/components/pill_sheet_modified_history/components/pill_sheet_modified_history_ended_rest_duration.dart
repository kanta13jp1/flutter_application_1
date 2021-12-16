import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/domain/calendar/components/pill_sheet_modified_history/components/pill_sheet_modified_history_date_component.dart';
import 'package:flutter_application_1/entity/pill_sheet_modified_history_value.dart';

class PillSheetModifiedHistoryEndedRestDuration extends StatelessWidget {
  final DateTime estimatedEventCausingDate;
  final EndedRestDurationValue? value;

  const PillSheetModifiedHistoryEndedRestDuration({
    Key? key,
    required this.estimatedEventCausingDate,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = this.value;
    if (value == null) {
      return Container();
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: Row(
          children: [
            PillSheetModifiedHistoryDate(
                estimatedEventCausingDate: estimatedEventCausingDate,
                effectivePillNumber:
                    PillSheetModifiedHistoryDateEffectivePillNumber.hyphen()),
            Spacer(),
            Container(
              width: PillSheetModifiedHistoryTakenActionLayoutWidths.trailing,
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "休薬終了",
                      style: TextStyle(
                        color: TextColor.main,
                        fontSize: 12,
                        fontFamily: FontFamily.japanese,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

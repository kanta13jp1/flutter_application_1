import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/domain/calendar/components/pill_sheet_modified_history/components/pill_sheet_modified_history_date_component.dart';
import 'package:flutter_application_1/entity/pill_sheet_modified_history_value.dart';

class PillSheetModifiedHistoryCreatePillSheetAction extends StatelessWidget {
  final DateTime estimatedEventCausingDate;
  final CreatedPillSheetValue? value;

  const PillSheetModifiedHistoryCreatePillSheetAction({
    Key? key,
    required this.estimatedEventCausingDate,
    required this.value,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: Row(
          children: [
            PillSheetModifiedHistoryDate(
              estimatedEventCausingDate: estimatedEventCausingDate,
              effectivePillNumber:
                  PillSheetModifiedHistoryDateEffectivePillNumber
                      .pillSheetCount(value?.pillSheetIDs ?? []),
            ),
            Spacer(),
            Container(
              width: PillSheetModifiedHistoryTakenActionLayoutWidths.trailing,
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "ピルシート追加",
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

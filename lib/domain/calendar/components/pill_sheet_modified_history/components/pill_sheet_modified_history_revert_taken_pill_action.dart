import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/domain/calendar/components/pill_sheet_modified_history/components/pill_sheet_modified_history_date_component.dart';
import 'package:flutter_application_1/entity/pill_sheet_modified_history_value.dart';

class PillSheetModifiedHistoryRevertTakenPillAction extends StatelessWidget {
  final DateTime estimatedEventCausingDate;
  final RevertTakenPillValue? value;

  const PillSheetModifiedHistoryRevertTakenPillAction({
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
                  PillSheetModifiedHistoryDateEffectivePillNumber.revert(value),
            ),
            Spacer(),
            Container(
              width: PillSheetModifiedHistoryTakenActionLayoutWidths.trailing,
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "服用取り消し",
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

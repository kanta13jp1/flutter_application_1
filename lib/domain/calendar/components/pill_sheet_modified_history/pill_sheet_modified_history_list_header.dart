import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/domain/calendar/components/pill_sheet_modified_history/components/pill_sheet_modified_history_date_component.dart';

class PillSheetModifiedHisotiryListHeader extends StatelessWidget {
  const PillSheetModifiedHisotiryListHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          SizedBox(
            width: PillSheetModifiedHistoryTakenActionLayoutWidths.leading,
          ),
          Spacer(),
          Container(
            width: PillSheetModifiedHistoryTakenActionLayoutWidths.trailing,
            child: Row(
              children: [
                Container(
                  width: 55,
                  child: Text(
                    "服用時間",
                    style: TextStyle(
                      color: TextColor.main,
                      fontFamily: FontFamily.japanese,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: PillSheetModifiedHistoryTakenActionLayoutWidths
                        .takenMark,
                  ),
                  child: Text(
                    "服用済み",
                    style: TextStyle(
                      color: TextColor.main,
                      fontFamily: FontFamily.japanese,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

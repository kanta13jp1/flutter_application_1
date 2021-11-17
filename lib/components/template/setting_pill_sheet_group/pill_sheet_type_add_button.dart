import 'package:flutter_application_1/components/template/setting_pill_sheet_group/pill_sheet_group_select_pill_sheet_type_page.dart';

import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/entity/pill_sheet_type.dart';

class PillSheetTypeAddButton extends StatelessWidget {
  final Function(PillSheetType) onAdd;
  final List<PillSheetType> pillSheetTypes;
  const PillSheetTypeAddButton({
    Key? key,
    required this.pillSheetTypes,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (pillSheetTypes.isEmpty) {
          showSettingPillSheetGroupSelectPillSheetTypePage(
            context: context,
            pillSheetType: null,
            onSelect: (pillSheetType) => onAdd(pillSheetType),
          );
        } else {
          onAdd(pillSheetTypes.last);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: TextColor.noshime,
              size: 20,
            ),
            SizedBox(width: 4),
            Text(
              "ピルシートを追加",
              style: TextStyle(
                color: TextColor.main,
                fontFamily: FontFamily.japanese,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

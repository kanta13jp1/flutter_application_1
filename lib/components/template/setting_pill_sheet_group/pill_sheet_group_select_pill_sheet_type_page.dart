import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/components/template/pill_sheet_type_setting/pill_sheet_type_select_body_template.dart';
import 'package:flutter_application_1/entity/pill_sheet_type.dart';

class PillSheetGroupSelectPillSheetTypePage extends HookWidget {
  final PillSheetType? pillSheetType;
  final Function(PillSheetType) onSelect;

  const PillSheetGroupSelectPillSheetTypePage(
      {Key? key, required this.pillSheetType, required this.onSelect})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: PilllColors.background,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 16),
                  Text(
                    "ピルの種類を選択",
                    style: TextStyle(
                      color: TextColor.main,
                      fontSize: 20,
                      fontFamily: FontFamily.japanese,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    PillSheetTypeSelectBodyTemplate(
                      onSelect: (e) {
                        analytics.logEvent(
                          name: "initial_setting_selected_pill_sheet_type",
                          parameters: {"pill_sheet_type": e.fullName},
                        );
                        Navigator.of(context).pop();
                        onSelect(e);
                      },
                      selectedPillSheetType: pillSheetType,
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void showSettingPillSheetGroupSelectPillSheetTypePage({
  required BuildContext context,
  required final PillSheetType? pillSheetType,
  required final Function(PillSheetType) onSelect,
}) {
  analytics.setCurrentScreen(
      screenName: "PillSheetGroupSelectPillSheetTypePage");
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => PillSheetGroupSelectPillSheetTypePage(
      pillSheetType: pillSheetType,
      onSelect: onSelect,
    ),
  );
}

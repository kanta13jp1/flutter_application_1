import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/domain/initial_setting/initial_setting_store.dart';
import 'package:flutter_application_1/components/atoms/buttons.dart';
import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/domain/initial_setting/menstruation/initial_setting_menstruation_page.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/domain/initial_setting/today_pill_number/explain_label.dart';
import 'package:flutter_application_1/domain/initial_setting/today_pill_number/select_today_pill_number_pill_sheet_list.dart';
import 'package:flutter_application_1/util/datetime/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class InitialSettingSelectTodayPillNumberPage extends HookWidget {
  const InitialSettingSelectTodayPillNumberPage({Key? key}) : super(key: key);

  String todayString() {
    return DateFormat.yMEd('ja').format(today());
  }

  @override
  Widget build(BuildContext context) {
    final store = useProvider(initialSettingStoreProvider);
    final state = useProvider(initialSettingStoreProvider.state);
    return Scaffold(
      backgroundColor: PilllColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "2/4",
          style: TextStyle(color: TextColor.black),
        ),
        backgroundColor: PilllColors.white,
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Stack(
              children: [
                ListView(
                  children: [
                    SizedBox(height: 24),
                    Text(
                      "??????(${todayString()})\n?????????????????????????????????????????????",
                      style: FontType.sBigTitle.merge(TextColorStyle.main),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 44),
                    Center(
                      child: SelectTodayPillNumberPillSheetList(
                        state: state,
                        store: store,
                      ),
                    ),
                    SizedBox(height: 24),
                    ExplainPillNumber(today: todayString()),
                    SizedBox(height: 16),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InconspicuousButton(
                        onPressed: () {
                          store.unsetTodayPillNumber();
                          analytics.logEvent(
                              name: "unknown_number_initial_setting");
                          Navigator.of(context).push(
                              InitialSettingMenstruationPageRoute.route());
                        },
                        text: "?????????????????????",
                      ),
                      SizedBox(height: 30),
                      PrimaryButton(
                        text: "??????",
                        onPressed: state.todayPillNumber == null
                            ? null
                            : () {
                                analytics.logEvent(
                                    name: "done_today_number_initial_setting");
                                Navigator.of(context).push(
                                    InitialSettingMenstruationPageRoute
                                        .route());
                              },
                      ),
                      SizedBox(height: 35),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension InitialSettingSelectTodayPillNumberPageRoute
    on InitialSettingSelectTodayPillNumberPage {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: "InitialSettingSelectTodayPillNumberPage"),
      builder: (_) => InitialSettingSelectTodayPillNumberPage(),
    );
  }
}

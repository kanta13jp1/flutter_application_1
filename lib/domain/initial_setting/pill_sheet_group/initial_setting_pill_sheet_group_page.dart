import 'package:flutter_svg/svg.dart';
import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/page/hud.dart';
import 'package:flutter_application_1/components/template/setting_pill_sheet_group/pill_sheet_group_select_pill_sheet_type_page.dart';
import 'package:flutter_application_1/components/template/setting_pill_sheet_group/setting_pill_sheet_group.dart';
import 'package:flutter_application_1/domain/initial_setting/initial_setting_state.dart';
import 'package:flutter_application_1/domain/initial_setting/today_pill_number/initial_setting_select_today_pill_number_page.dart';
import 'package:flutter_application_1/domain/initial_setting/initial_setting_store.dart';
import 'package:flutter_application_1/components/atoms/buttons.dart';
import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_application_1/router/router.dart';
import 'package:flutter_application_1/signin/signin_sheet.dart';
import 'package:flutter_application_1/signin/signin_sheet_state.dart';
import 'package:flutter_application_1/entity/link_account_type.dart';
import 'package:flutter_application_1/entity/pill_sheet_type.dart';

class InitialSettingPillSheetGroupPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final store = useProvider(initialSettingStoreProvider);
    final state = useProvider(initialSettingStoreProvider.state);
    if (state.isAccountCooperationDidEnd) {
      Future(() async {
        if (await store.canEndInitialSetting()) {
          AppRouter.signinAccount(context);
        }
        store.hideHUD();
      });
    }
    return HUD(
      shown: state.isLoading,
      child: Scaffold(
        backgroundColor: PilllColors.background,
        appBar: AppBar(
          title: Text(
            "1/4",
            style: TextStyle(color: TextColor.black),
          ),
          backgroundColor: PilllColors.white,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      Text(
                        "処方されるピルについて\n教えてください",
                        style: FontType.sBigTitle.merge(TextColorStyle.main),
                        textAlign: TextAlign.center,
                      ),
                      InitialSettingPillSheetGroupPageBody(
                          state: state, store: store),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: PilllColors.background,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.pillSheetTypes.isNotEmpty)
                          PrimaryButton(
                            text: "次へ",
                            onPressed: () async {
                              analytics.logEvent(
                                  name: "next_to_pill_sheet_count");
                              Navigator.of(context).push(
                                  InitialSettingSelectTodayPillNumberPageRoute
                                      .route());
                            },
                          ),
                        if (!state.isAccountCooperationDidEnd) ...[
                          SizedBox(height: 20),
                          AlertButton(
                            text: "すでにアカウントをお持ちの方はこちら",
                            onPressed: () {
                              analytics.logEvent(
                                  name: "pressed_initial_setting_signin");
                              showSigninSheet(
                                context,
                                SigninSheetStateContext.initialSetting,
                                (accountType) async {
                                  store.showHUD();
                                  if (await store.canEndInitialSetting()) {
                                    AppRouter.signinAccount(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Text(
                                            "${accountType.providerName}でログインしました"),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                        SizedBox(height: 35),
                      ],
                    ),
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

class InitialSettingPillSheetGroupPageBody extends StatelessWidget {
  const InitialSettingPillSheetGroupPageBody({
    Key? key,
    required this.state,
    required this.store,
  }) : super(key: key);

  final InitialSettingState state;
  final InitialSettingStateStore store;

  @override
  Widget build(BuildContext context) {
    if (state.pillSheetTypes.isEmpty) {
      return Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            SvgPicture.asset("images/empty_pill_sheet_type.svg"),
            SizedBox(height: 24),
            PrimaryButton(
                onPressed: () {
                  showSettingPillSheetGroupSelectPillSheetTypePage(
                    context: context,
                    pillSheetType: null,
                    onSelect: (pillSheetType) {
                      store.addPillSheetType(pillSheetType);
                    },
                  );
                },
                text: "ピルの種類を選ぶ"),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 6),
          SettingPillSheetGroup(
              pillSheetTypes: state.pillSheetTypes,
              onAdd: (pillSheetType) {
                analytics.logEvent(
                    name: "initial_setting_add_pill_sheet_group",
                    parameters: {"pill_sheet_type": pillSheetType.fullName});
                store.addPillSheetType(pillSheetType);
              },
              onChange: (index, pillSheetType) {
                analytics.logEvent(
                    name: "initial_setting_change_pill_sheet_group",
                    parameters: {
                      "index": index,
                      "pill_sheet_type": pillSheetType.fullName
                    });
                store.changePillSheetType(index, pillSheetType);
              },
              onDelete: (index) {
                analytics.logEvent(
                    name: "initial_setting_delete_pill_sheet_group",
                    parameters: {"index": index});
                store.removePillSheetType(index);
              }),
        ],
      );
    }
  }
}

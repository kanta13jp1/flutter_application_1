import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/atoms/buttons.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/components/molecules/app_card.dart';
import 'package:flutter_application_1/components/molecules/premium_badge.dart';
import 'package:flutter_application_1/domain/calendar/calendar_store.dart';
import 'package:flutter_application_1/domain/calendar/components/pill_sheet_modified_history/components/pill_sheet_modified_history_more_button.dart';
import 'package:flutter_application_1/domain/calendar/components/pill_sheet_modified_history/pill_sheet_modified_history_list.dart';
import 'package:flutter_application_1/domain/calendar/components/pill_sheet_modified_history/pill_sheet_modified_history_list_header.dart';
import 'package:flutter_application_1/domain/premium_introduction/premium_introduction_sheet.dart';
import 'package:flutter_application_1/domain/premium_trial/premium_trial_complete_modal.dart';
import 'package:flutter_application_1/domain/premium_trial/premium_trial_modal.dart';
import 'package:flutter_application_1/emoji/emoji.dart';
import 'package:flutter_application_1/entity/pill_sheet_modified_history.dart';

class CalendarPillSheetModifiedHistoryCardState {
  static final pillSheetModifiedHistoriesThreshold = 6;
  final List<PillSheetModifiedHistory> _allPillSheetModifiedHistories;
  final bool isPremium;
  final bool isTrial;
  final DateTime? trialDeadlineDate;

  CalendarPillSheetModifiedHistoryCardState(
    this._allPillSheetModifiedHistories, {
    required this.isPremium,
    required this.isTrial,
    required this.trialDeadlineDate,
  });

  bool get moreButtonIsShown =>
      _allPillSheetModifiedHistories.length >
      CalendarPillSheetModifiedHistoryCardState
          .pillSheetModifiedHistoriesThreshold;
  List<PillSheetModifiedHistory> get pillSheetModifiedHistories {
    if (_allPillSheetModifiedHistories.length >
        CalendarPillSheetModifiedHistoryCardState
            .pillSheetModifiedHistoriesThreshold) {
      final copied = [..._allPillSheetModifiedHistories];
      copied.removeRange(
        CalendarPillSheetModifiedHistoryCardState
                .pillSheetModifiedHistoriesThreshold -
            1,
        copied.length,
      );
      return copied;
    } else {
      return _allPillSheetModifiedHistories;
    }
  }
}

class CalendarPillSheetModifiedHistoryCard extends StatelessWidget {
  final CalendarPillSheetModifiedHistoryCardState state;
  final CalendarPageStateStore store;

  const CalendarPillSheetModifiedHistoryCard({
    Key? key,
    required this.state,
    required this.store,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "服用履歴",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.japanese,
                    fontSize: 20,
                    color: TextColor.main,
                  ),
                ),
                if (!state.isPremium) ...[
                  SizedBox(width: 8),
                  PremiumBadge(),
                ],
              ],
            ),
            SizedBox(height: 16),
            PillSheetModifiedHisotiryListHeader(),
            SizedBox(height: 4),
            ...() {
              if (state.isPremium || state.isTrial) {
                return [
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: CalendarPillSheetModifiedHistoryList(
                      padding: null,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      pillSheetModifiedHistories:
                          state.pillSheetModifiedHistories,
                    ),
                  ),
                  if (state.moreButtonIsShown)
                    PillSheetModifiedHistoryMoreButton(state: state),
                ];
              } else {
                return [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: CalendarPillSheetModifiedHistoryList(
                          padding: null,
                          scrollPhysics: NeverScrollableScrollPhysics(),
                          pillSheetModifiedHistories:
                              state.pillSheetModifiedHistories,
                        ),
                      ),
                      Positioned.fill(
                        child: ClipRect(
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                child: Container(
                                  color: Colors.black.withOpacity(0),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(lockEmoji,
                                        style: TextStyle(fontSize: 40)),
                                    SizedBox(height: 12),
                                    Text(
                                      "服用履歴はプレミアム機能です",
                                      style: TextStyle(
                                        color: TextColor.main,
                                        fontSize: 14,
                                        fontFamily: FontFamily.japanese,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    SizedBox(
                                      width: 204,
                                      child: AppOutlinedButton(
                                        text: "くわしくみる",
                                        onPressed: () {
                                          if (state.trialDeadlineDate == null) {
                                            showPremiumTrialModal(context, () {
                                              showPremiumTrialCompleteModalPreDialog(
                                                  context);
                                            });
                                          } else {
                                            showPremiumIntroductionSheet(
                                                context);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ];
              }
            }(),
          ],
        ),
      ),
    );
  }
}

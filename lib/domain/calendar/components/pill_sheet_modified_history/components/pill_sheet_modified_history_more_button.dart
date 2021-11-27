import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/components/atoms/buttons.dart';
import 'package:flutter_application_1/domain/calendar/components/pill_sheet_modified_history/pill_sheet_modified_history_card.dart';
import 'package:flutter_application_1/domain/pill_sheet_modified_history/pill_sheet_modified_history_page.dart';
import 'package:flutter_application_1/domain/premium_introduction/premium_introduction_sheet.dart';
import 'package:flutter_application_1/domain/premium_trial/premium_trial_complete_modal.dart';
import 'package:flutter_application_1/domain/premium_trial/premium_trial_modal.dart';
import 'package:flutter/material.dart';

class PillSheetModifiedHistoryMoreButton extends StatelessWidget {
  const PillSheetModifiedHistoryMoreButton({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CalendarPillSheetModifiedHistoryCardState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AlertButton(
            text: "もっと見る",
            onPressed: () {
              analytics.logEvent(name: "pill_sheet_modified_history_more");
              if (state.isPremium || state.isTrial) {
                Navigator.of(context)
                    .push(PillSheetModifiedHistoriesPageRoute.route());
              } else {
                if (state.trialDeadlineDate == null) {
                  showPremiumTrialModal(context, () {
                    showPremiumTrialCompleteModalPreDialog(context);
                  });
                } else {
                  showPremiumIntroductionSheet(context);
                }
              }
            }),
      ],
    );
  }
}

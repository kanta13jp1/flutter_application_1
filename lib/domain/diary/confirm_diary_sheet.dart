import 'package:flutter_application_1/components/atoms/buttons.dart';
import 'package:flutter_application_1/components/page/discard_dialog.dart';
import 'package:flutter_application_1/domain/diary/post_diary_page.dart';
import 'package:flutter_application_1/entity/diary.dart';
import 'package:flutter_application_1/service/diary.dart';
import 'package:flutter_application_1/state/diary.dart';
import 'package:flutter_application_1/store/confirm_diary.dart';
import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/util/formatter/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _confirmDiaryProvider =
    StateNotifierProvider.autoDispose.family<ConfirmDiary, Diary>((ref, diary) {
  final service = ref.watch(diaryServiceProvider);
  return ConfirmDiary(service, DiaryState(diary: diary.copyWith()));
});

class ConfirmDiarySheet extends HookConsumerWidget {
  final Diary _diary;

  ConfirmDiarySheet(this._diary);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_confirmDiaryProvider(_diary));
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: PilllColors.white,
      ),
      padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(context, ref),
            ...[
              if (state.hasPhysicalConditionStatus()) _physicalCondition(ref),
              _physicalConditionDetails(),
              if (state.diary.hasSex) _sex(),
              _memo(),
            ].map((e) => _withContentSpacer(e)),
          ]),
    );
  }

  Widget _withContentSpacer(Widget content) {
    return Container(
      child: content,
      padding: EdgeInsets.only(top: 10, bottom: 10),
    );
  }

  Widget _title(BuildContext context, WidgetRef ref) {
    final store = ref.watch(_confirmDiaryProvider(_diary).notifier);
    final state = ref.watch(_confirmDiaryProvider(_diary));
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(DateTimeFormatter.yearAndMonthAndDay(state.diary.date),
            style: FontType.sBigTitle.merge(TextColorStyle.main)),
        Spacer(),
        IconButton(
          icon: SvgPicture.asset("images/edit.svg"),
          onPressed: () {
            Navigator.of(context)
                .push(PostDiaryPageRoute.route(state.diary.date, state.diary));
          },
        ),
        SizedBox(width: 12),
        IconButton(
          icon: SvgPicture.asset("images/trash.svg"),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return DiscardDialog(
                    title: "日記を削除します",
                    message: Text("削除された日記は復元ができません",
                        style: FontType.assisting.merge(TextColorStyle.main)),
                    actions: [
                      AlertButton(
                        text: "キャンセル",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      AlertButton(
                        text: "削除する",
                        onPressed: () {
                          int counter = 0;
                          store.delete().then((value) => Navigator.popUntil(
                              context, (route) => counter++ >= 1));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
        ),
      ],
    );
  }

  Widget _physicalConditionImage(PhysicalConditionStatus? status) {
    switch (status) {
      case PhysicalConditionStatus.fine:
        return SvgPicture.asset("images/laugh.svg",
            color: PilllColors.secondary);
      case PhysicalConditionStatus.bad:
        return SvgPicture.asset("images/angry.svg",
            color: PilllColors.secondary);
      default:
        return Container();
    }
  }

  Widget _physicalCondition(WidgetRef ref) {
    final state = ref.watch(_confirmDiaryProvider(_diary));
    return Row(
      children: [
        Text("体調", style: FontType.componentTitle.merge(TextColorStyle.black)),
        SizedBox(width: 16),
        _physicalConditionImage(state.diary.physicalConditionStatus),
      ],
    );
  }

  Widget _physicalConditionDetails() {
    final state = useProvider(_confirmDiaryProvider(_diary).state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          children: state.diary.physicalConditions
              .map((e) => ChoiceChip(
                    label: Text(e),
                    labelStyle: FontType.assisting.merge(TextColorStyle.white),
                    selectedColor: PilllColors.secondary,
                    selected: true,
                    onSelected: (selected) {},
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _sex() {
    return Container(
      padding: EdgeInsets.all(4),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: PilllColors.thinSecondary),
      child: SvgPicture.asset("images/heart.svg", color: PilllColors.secondary),
    );
  }

  Widget _memo() {
    final state = useProvider(_confirmDiaryProvider(_diary).state);
    return Text(
      state.diary.memo,
      maxLines: 2,
    );
  }
}

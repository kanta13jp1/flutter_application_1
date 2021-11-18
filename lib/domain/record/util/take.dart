import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_application_1/database/batch.dart';
import 'package:flutter_application_1/domain/modal/release_note.dart';
import 'package:flutter_application_1/domain/record/record_page_store.dart';
import 'package:flutter_application_1/entity/pill_sheet.dart';
import 'package:flutter_application_1/entity/pill_sheet_group.dart';
import 'package:flutter_application_1/error_log.dart';
import 'package:flutter_application_1/service/pill_sheet.dart';
import 'package:flutter_application_1/service/pill_sheet_group.dart';
import 'package:flutter_application_1/service/pill_sheet_modified_history.dart';
import 'package:flutter_application_1/util/shared_preference/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> effectAfterTaken({
  required BuildContext context,
  required Future<void>? taken,
  required RecordPageStore store,
}) async {
  final _taken = taken;
  if (_taken == null) {
    return;
  }
  try {
    await _taken;
    FlutterAppBadger.removeBadge();
    _requestInAppReview();
    await showReleaseNotePreDialog(context);
  } catch (exception, stack) {
    errorLogger.recordError(exception, stack);
    store.handleException(exception);
  }
}

_requestInAppReview() {
  SharedPreferences.getInstance().then((store) async {
    final key = IntKey.totalCountOfActionForTakenPill;
    int? value = store.getInt(key);
    if (value == null) {
      value = 0;
    }
    value += 1;
    store.setInt(key, value);
    if (value % 7 != 0) {
      return;
    }
    if (await InAppReview.instance.isAvailable()) {
      await InAppReview.instance.requestReview();
    }
  });
}

Future<PillSheetGroup?> take({
  required DateTime takenDate,
  required PillSheetGroup pillSheetGroup,
  required PillSheet activedPillSheet,
  required BatchFactory batchFactory,
  required PillSheetService pillSheetService,
  required PillSheetModifiedHistoryService pillSheetModifiedHistoryService,
  required PillSheetGroupService pillSheetGroupService,
}) async {
  if (activedPillSheet.todayPillNumber ==
      activedPillSheet.lastTakenPillNumber) {
    return null;
  }

  final batch = batchFactory.batch();

  final updatedPillSheets = pillSheetGroup.pillSheets.map((pillSheet) {
    if (pillSheet.groupIndex > activedPillSheet.groupIndex) {
      return pillSheet;
    }
    if (pillSheet.isEnded) {
      return pillSheet;
    }

    // takenDateよりも予測するピルシートが大きい場合はactivedPillSheetじゃないPillSheetと判断。
    // そのピルシートの最終日で予測する最終服用日を記録する
    if (takenDate.isAfter(pillSheet.estimatedLastTakenDate)) {
      return pillSheet.copyWith(
          lastTakenDate: pillSheet.estimatedLastTakenDate);
    } else {
      return pillSheet.copyWith(lastTakenDate: takenDate);
    }
  }).toList();

  final updatedPillSheetGroup =
      pillSheetGroup.copyWith(pillSheets: updatedPillSheets);
  final updatedIndexses = pillSheetGroup.pillSheets.asMap().keys.where(
        (index) =>
            pillSheetGroup.pillSheets[index] !=
            updatedPillSheetGroup.pillSheets[index],
      );

  if (updatedIndexses.isEmpty) {
    return null;
  }

  pillSheetService.update(
    batch,
    updatedPillSheets,
  );
  pillSheetGroupService.update(batch, updatedPillSheetGroup);

  final before = pillSheetGroup.pillSheets[updatedIndexses.first];
  final after = updatedPillSheetGroup.pillSheets[updatedIndexses.last];
  final history =
      PillSheetModifiedHistoryServiceActionFactory.createTakenPillAction(
    pillSheetGroupID: pillSheetGroup.id,
    before: before,
    after: after,
  );
  pillSheetModifiedHistoryService.add(batch, history);

  await batch.commit();

  return updatedPillSheetGroup;
}

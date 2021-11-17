import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_application_1/error_log.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/database/database.dart';
import 'package:flutter_application_1/service/user.dart';

final purchaseServiceProvider = Provider((ref) => PurchaseService());

class PurchaseService {
  Future<Offerings> fetchOfferings() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      return offerings;
    } catch (exception, stack) {
      errorLogger.recordError(exception, stack);
      print(exception);
      rethrow;
    }
  }
}

const premiumEntitlements = "Premium";

Future<void> callUpdatePurchaseInfo(PurchaserInfo info) async {
  analytics.logEvent(name: "start_update_purchase_info");
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    errorLogger.recordError(
        "unexpected uid is not found when purchase info is update",
        StackTrace.current);
    return;
  }

  final userService = UserService(DatabaseConnection(uid));
  final premiumEntitlement = info.entitlements.all[premiumEntitlements];
  try {
    analytics.logEvent(name: "call_update_purchase_info");
    await userService.updatePurchaseInfo(
      isActivated: premiumEntitlement?.isActive,
      entitlementIdentifier: premiumEntitlement?.identifier,
      premiumPlanIdentifier: premiumEntitlement?.productIdentifier,
      purchaseAppID: info.originalAppUserId,
      activeSubscriptions: info.activeSubscriptions,
      originalPurchaseDate: info.originalPurchaseDate,
    );
    analytics.logEvent(name: "end_update_purchase_info");
  } catch (exception, stack) {
    errorLogger.recordError(exception, stack);
  }
}

Future<void> syncPurchaseInfo() async {
  analytics.logEvent(name: "start_sync_purchase_info");
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    errorLogger.recordError(
        "unexpected uid is not found when purchase info to sync",
        StackTrace.current);
    return;
  }

  PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
  final premiumEntitlement =
      purchaserInfo.entitlements.all[premiumEntitlements];
  final isActivated =
      premiumEntitlement == null ? false : premiumEntitlement.isActive;

  try {
    final userService = UserService(DatabaseConnection(uid));
    analytics.logEvent(name: "call_service_sync_purchase_info");
    await userService.syncPurchaseInfo(isActivated: isActivated);
    analytics.logEvent(name: "end_sync_purchase_info");
  } catch (exception, stack) {
    errorLogger.recordError(exception, stack);
  }
}

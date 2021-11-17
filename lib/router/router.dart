import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/domain/root/root.dart';
import 'package:flutter_application_1/service/push_notification.dart';
import 'package:flutter_application_1/util/shared_preference/keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
// NOTE: This method call after user end all initialSetting
// OR user signed with 3rd party provider
// So, Don't forget when this function is edited. Both test necessary .
  static void endInitialSetting(BuildContext context) {
    analytics.logEvent(name: "end_initial_setteing");
    SharedPreferences.getInstance().then((storage) {
      storage.setBool(BoolKey.didEndInitialSetting, true);
      requestNotificationPermissions().then((value) {
        listenNotificationEvents();
        Navigator.popUntil(context, (router) => router.isFirst);
        rootKey.currentState?.showHome();
      });
    });
  }

  static void signinAccount(BuildContext context) {
    analytics.logEvent(
        name: "initial_setting_signin_account",
        parameters: {"uid": FirebaseAuth.instance.currentUser?.uid});
    return endInitialSetting(context);
  }

  static Future<void> routeToInitialSetting(BuildContext context) async {
    analytics.logEvent(name: "route_to_initial_settings");
    final storage = await SharedPreferences.getInstance();
    storage.setBool(BoolKey.didEndInitialSetting, false);
    Navigator.popUntil(context, (router) => router.isFirst);
    rootKey.currentState?.reload();
  }
}

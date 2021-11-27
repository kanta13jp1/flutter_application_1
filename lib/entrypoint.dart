import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/domain/root/root.dart';
import 'package:flutter_application_1/error/universal_error_page.dart';
import 'package:flutter_application_1/global_method_channel.dart';
import 'package:flutter_application_1/service/purchase.dart';
import 'package:flutter_application_1/util/environment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_application_1/app/secret.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

Future<void> entrypoint() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('ja_JP');
  await Firebase.initializeApp();

  if (Environment.isLocal) {
    connectToEmulator();
  }
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return UniversalErrorPage(
      error: details.exception.toString(),
      child: null,
      reload: () {
        rootKey.currentState?.reload();
      },
    );
  };
  // MEMO: FirebaseCrashlytics#recordFlutterError called dumpErrorToConsole in function.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  definedChannel();
  runZonedGuarded(() async {
    runApp(ProviderScope(child: App()));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

Future<void> initializePurchase(String uid) async {
  await Purchases.setDebugLogsEnabled(Environment.isDevelopment);
  await Purchases.setup(Secret.revenueCatPublicAPIKey, appUserId: uid);
  Purchases.addPurchaserInfoUpdateListener(callUpdatePurchaseInfo);
}

void connectToEmulator() {
  await syncPurchaseInfo();
  final domain = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFirestore.instance.settings = Settings(
      persistenceEnabled: false, host: '$domain:8080', sslEnabled: false);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: firebaseAnalytics),
      ],
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: true,
          color: PilllColors.white,
          elevation: 3,
        ),
        primaryColor: PilllColors.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        toggleableActiveColor: PilllColors.primary,
        cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
            textTheme: CupertinoTextThemeData(textStyle: FontType.xBigTitle)),
        buttonTheme: ButtonThemeData(
          buttonColor: PilllColors.secondary,
          disabledColor: PilllColors.disable,
          textTheme: ButtonTextTheme.primary,
          colorScheme: ColorScheme.light(
            primary: PilllColors.primary,
            secondary: PilllColors.accent,
          ),
        ),
      ),
      home: ProviderScope(
        child: Root(
          key: rootKey,
        ),
      ),
    );
  }
}

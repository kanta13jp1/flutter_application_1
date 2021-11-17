import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter_application_1/database/database.dart';
import 'package:flutter_application_1/domain/premium_function_survey/premium_function_survey_element_type.dart';
import 'package:flutter_application_1/entity/demographic.dart';
import 'package:flutter_application_1/entity/package.dart';
import 'package:flutter_application_1/entity/premium_function_survey.dart';
import 'package:flutter_application_1/entity/setting.dart';
import 'package:flutter_application_1/entity/user.dart';
import 'package:flutter_application_1/util/datetime/day.dart';
import 'package:flutter_application_1/util/shared_preference/keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info/package_info.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userServiceProvider =
    Provider((ref) => UserService(ref.watch(databaseProvider)));

class UserService {
  final DatabaseConnection _database;
  UserService(this._database);

  Future<User> prepare(String uid) async {
    print("call prepare for $uid");
    final user = await fetch().catchError((error) {
      if (error is UserNotFound) {
        return _create(uid).then((_) => fetch());
      }
      throw FormatException(
          "cause exception when failed fetch and create user for $error, stackTrace: ${StackTrace.current.toString()}");
    });
    return user;
  }

  Future<User> fetch() {
    print("call fetch");
    return _database.userReference().get().then((document) {
      if (!document.exists) {
        throw UserNotFound();
      }
      print("fetched user ${document.data()}");
      return User.fromJson(document.data() as Map<String, dynamic>);
    });
  }

  Future<DocumentSnapshot> _fetchRawDocumentSnapshot() {
    return _database.userReference().get();
  }

  Future<void> recordUserIDs() async {
    try {
      final document = await _fetchRawDocumentSnapshot();
      final user = User.fromJson(document.data() as Map<String, dynamic>);
      final documentID = document.id;
      final sharedPreferences = await SharedPreferences.getInstance();

      List<String> userDocumentIDSets = user.userDocumentIDSets;
      if (!userDocumentIDSets.contains(documentID)) {
        userDocumentIDSets.add(documentID);
      }

      final lastSigninAnonymousUID =
          sharedPreferences.getString(StringKey.lastSigninAnonymousUID);
      List<String> anonymousUserIDSets = user.anonymousUserIDSets;
      if (lastSigninAnonymousUID != null &&
          !anonymousUserIDSets.contains(lastSigninAnonymousUID)) {
        anonymousUserIDSets.add(lastSigninAnonymousUID);
      }
      final firebaseCurrentUserID =
          firebaseAuth.FirebaseAuth.instance.currentUser?.uid;
      List<String> firebaseCurrentUserIDSets = user.firebaseCurrentUserIDSets;
      if (firebaseCurrentUserID != null &&
          !firebaseCurrentUserIDSets.contains(firebaseCurrentUserID)) {
        firebaseCurrentUserIDSets.add(firebaseCurrentUserID);
      }

      await _database.userReference().set(
        {
          UserFirestoreFieldKeys.userDocumentIDSets: userDocumentIDSets,
          UserFirestoreFieldKeys.firebaseCurrentUserIDSets:
              firebaseCurrentUserIDSets,
          UserFirestoreFieldKeys.anonymousUserIDSets: anonymousUserIDSets,
        },
        SetOptions(merge: true),
      );
    } catch (error) {
      print(error);
    }
  }

  Stream<User> stream() {
    return _database
        .userReference()
        .snapshots(includeMetadataChanges: true)
        .map((event) => User.fromJson(event.data() as Map<String, dynamic>));
  }

  Future<void> updatePurchaseInfo({
    required bool? isActivated,
    required String? entitlementIdentifier,
    required String? premiumPlanIdentifier,
    required String purchaseAppID,
    required List<String> activeSubscriptions,
    required String? originalPurchaseDate,
  }) async {
    await _database.userReference().set({
      if (isActivated != null) UserFirestoreFieldKeys.isPremium: isActivated,
      UserFirestoreFieldKeys.purchaseAppID: purchaseAppID
    }, SetOptions(merge: true));
    final privates = {
      if (premiumPlanIdentifier != null)
        UserPrivateFirestoreFieldKeys.latestPremiumPlanIdentifier:
            premiumPlanIdentifier,
      if (originalPurchaseDate != null)
        UserPrivateFirestoreFieldKeys.originalPurchaseDate:
            originalPurchaseDate,
      if (activeSubscriptions.isNotEmpty)
        UserPrivateFirestoreFieldKeys.activeSubscriptions: activeSubscriptions,
      if (entitlementIdentifier != null)
        UserPrivateFirestoreFieldKeys.entitlementIdentifier:
            entitlementIdentifier,
    };
    if (privates.isNotEmpty) {
      await _database
          .userPrivateReference()
          .set({...privates}, SetOptions(merge: true));
    }
  }

  Future<void> syncPurchaseInfo({
    required bool isActivated,
  }) async {
    await _database.userReference().set({
      UserFirestoreFieldKeys.isPremium: isActivated,
    }, SetOptions(merge: true));
  }

  Future<void> deleteSettings() {
    return _database
        .userReference()
        .update({UserFirestoreFieldKeys.settings: FieldValue.delete()});
  }

  Future<void> setFlutterMigrationFlag() {
    return _database.userReference().set(
      {UserFirestoreFieldKeys.migratedFlutter: true},
      SetOptions(merge: true),
    );
  }

  Future<void> _create(String uid) async {
    print("call create for $uid");
    final sharedPreferences = await SharedPreferences.getInstance();
    final anonymousUserID =
        sharedPreferences.getString(StringKey.lastSigninAnonymousUID);
    return _database.userReference().set(
      {
        if (anonymousUserID != null)
          UserFirestoreFieldKeys.anonymousUserID: anonymousUserID,
        UserFirestoreFieldKeys.userIDWhenCreateUser: uid,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> registerRemoteNotificationToken(String? token) {
    print("token: $token");
    return _database.userPrivateReference().set(
      {UserPrivateFirestoreFieldKeys.fcmToken: token},
      SetOptions(merge: true),
    );
  }

  Future<void> saveLaunchInfo() {
    final os = Platform.operatingSystem;
    return PackageInfo.fromPlatform().then((info) {
      final packageInfo = Package(
          latestOS: os,
          appName: info.appName,
          buildNumber: info.buildNumber,
          appVersion: info.version);
      return _database.userReference().set(
          {UserFirestoreFieldKeys.packageInfo: packageInfo.toJson()},
          SetOptions(merge: true));
    });
  }

  Future<void> saveStats() async {
    final store = await SharedPreferences.getInstance();

    final lastLoginVersion =
        await PackageInfo.fromPlatform().then((value) => value.version);
    String? beginingVersion = store.getString(StringKey.beginingVersionKey);
    if (beginingVersion == null) {
      final v = lastLoginVersion;
      await store.setString(StringKey.beginingVersionKey, v);
      beginingVersion = v;
    }

    final now = DateTime.now();
    final timeZoneName = now.timeZoneName;
    final timeZoneOffset = now.timeZoneOffset;

    return _database.userReference().set({
      "stats": {
        "lastLoginAt": now,
        "beginingVersion": beginingVersion,
        "lastLoginVersion": lastLoginVersion,
        "timeZoneName": timeZoneName,
        "timeZoneOffset":
            "${timeZoneOffset.isNegative ? "-" : "+"}${timeZoneOffset.inHours}",
      }
    }, SetOptions(merge: true));
  }

  Future<void> linkApple(String? email) async {
    await _database.userReference().set({
      UserFirestoreFieldKeys.isAnonymous: false,
    }, SetOptions(merge: true));
    return _database.userPrivateReference().set({
      if (email != null) UserPrivateFirestoreFieldKeys.appleEmail: email,
      UserPrivateFirestoreFieldKeys.isLinkedApple: true,
    }, SetOptions(merge: true));
  }

  Future<void> linkGoogle(String? email) async {
    await _database.userReference().set({
      UserFirestoreFieldKeys.isAnonymous: false,
    }, SetOptions(merge: true));
    return _database.userPrivateReference().set({
      if (email != null) UserPrivateFirestoreFieldKeys.googleEmail: email,
      UserPrivateFirestoreFieldKeys.isLinkedGoogle: true,
    }, SetOptions(merge: true));
  }

  Future<void> postDemographic(Demographic demographic) {
    return _database.userPrivateReference().set(
        {UserPrivateFirestoreFieldKeys.demographic: demographic.toJson()},
        SetOptions(merge: true));
  }

  Future<void> trial(Setting setting) {
    return _database.userReference().set({
      UserFirestoreFieldKeys.isTrial: true,
      UserFirestoreFieldKeys.beginTrialDate: now(),
      UserFirestoreFieldKeys.trialDeadlineDate: now().add(Duration(days: 30)),
      UserFirestoreFieldKeys.settings: setting.toJson(),
      UserFirestoreFieldKeys.hasDiscountEntitlement: true,
    }, SetOptions(merge: true));
  }

  // NOTE: 下位互換のために一時的にhasDiscountEntitlementをtrueにしていくスクリプト。
  // サーバー側での制御が無駄になるけど、理屈ではこれで生合成が取れる
  Future<void> temporarySyncronizeDiscountEntitlement(User user) async {
    final discountEntitlementDeadlineDate =
        user.discountEntitlementDeadlineDate;
    final bool hasDiscountEntitlement;
    if (discountEntitlementDeadlineDate == null) {
      hasDiscountEntitlement = true;
    } else {
      hasDiscountEntitlement = !now().isAfter(discountEntitlementDeadlineDate);
    }
    return _database.userReference().set({
      UserFirestoreFieldKeys.hasDiscountEntitlement: hasDiscountEntitlement,
    }, SetOptions(merge: true));
  }

  Future<void> sendPremiumFunctionSurvey(
      List<PremiumFunctionSurveyElementType> elements, String message) async {
    final PremiumFunctionSurvey premiumFunctionSurvey = PremiumFunctionSurvey(
      elements: elements,
      message: message,
    );
    return _database.userPrivateReference().set({
      UserPrivateFirestoreFieldKeys.premiumFunctionSurvey:
          premiumFunctionSurvey.toJson()
    }, SetOptions(merge: true));
  }
}

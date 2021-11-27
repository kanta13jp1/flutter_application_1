import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/auth/exception.dart';
import 'package:flutter_application_1/entity/link_account_type.dart';
import 'package:flutter_application_1/error_log.dart';
import 'package:flutter_application_1/service/user.dart';
import 'package:flutter_application_1/auth/apple.dart';
import 'package:flutter_application_1/auth/google.dart';

Future<SigninWithAppleState> callLinkWithApple(UserService userService) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw AssertionError("Required Firebase user");
  }
  try {
    final credential = await linkWithApple(user);
    if (credential == null) {
      return Future.value(SigninWithAppleState.cancel);
    }
    final email = credential.email;
    assert(email != null);
    userService.linkApple(email);

    return Future.value(SigninWithAppleState.determined);
  } on FirebaseAuthException catch (error, stackTrace) {
    errorLogger.recordError(error, stackTrace);
    print(
        "FirebaseAuthException $error, code: ${error.code}, stack: ${stackTrace.toString()}");
    final mappedException =
        mapFromFirebaseAuthException(error, LinkAccountType.apple);
    if (mappedException != null) {
      throw mappedException;
    }
    rethrow;
  } catch (error, stack) {
    print("$error, ${StackTrace.current.toString()}");
    errorLogger.recordError(error, stack);
    rethrow;
  }
}

Future<SigninWithGoogleState> callLinkWithGoogle(
    UserService userService) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw AssertionError("Required Firebase user");
  }
  try {
    final credential = await linkWithGoogle(user);
    if (credential == null) {
      return Future.value(SigninWithGoogleState.cancel);
    }

    final email = credential.email;
    assert(email != null);
    userService.linkGoogle(email);

    return Future.value(SigninWithGoogleState.determined);
  } on FirebaseAuthException catch (error, stackTrace) {
    errorLogger.recordError(error, stackTrace);
    print(
        "FirebaseAuthException $error, code: ${error.code}, stack: ${stackTrace.toString()}");
    final mappedException =
        mapFromFirebaseAuthException(error, LinkAccountType.google);
    if (mappedException != null) {
      throw mappedException;
    }
    rethrow;
  } catch (error, stack) {
    print("$error, ${StackTrace.current.toString()}");
    errorLogger.recordError(error, stack);
    rethrow;
  }
}

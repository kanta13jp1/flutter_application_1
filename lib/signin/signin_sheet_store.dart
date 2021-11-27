import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/auth/apple.dart';
import 'package:flutter_application_1/auth/boilerplate.dart';
import 'package:flutter_application_1/auth/google.dart';
import 'package:flutter_application_1/service/user.dart';
import 'package:flutter_application_1/signin/signin_sheet_state.dart';
import 'package:riverpod/riverpod.dart';

final signinSheetStoreProvider = StateNotifierProvider.autoDispose
    .family<SigninSheetStore, SigninSheetState, SigninSheetStateContext>(
  (ref, context) => SigninSheetStore(context, ref.watch(userServiceProvider)),
);

class SigninSheetStore extends StateNotifier<SigninSheetState> {
  final UserService _userService;
  SigninSheetStore(SigninSheetStateContext context, this._userService)
      : super(SigninSheetState(context: context)) {
    reset();
  }

  reset() {
    state = state.copyWith(exception: null);
  }

  Future<SigninWithAppleState> handleApple() {
    if (state.isLoginMode) {
      analytics.logEvent(name: "signin_sheet_sign_in_apple");
      return signInWithApple().then((value) => value == null
          ? SigninWithAppleState.cancel
          : SigninWithAppleState.determined);
    } else {
      analytics.logEvent(name: "signin_sheet_link_with_apple");
      return callLinkWithApple(_userService);
    }
  }

  Future<SigninWithGoogleState> handleGoogle() {
    if (state.isLoginMode) {
      analytics.logEvent(name: "signin_sheet_sign_in_google");
      return signInWithGoogle().then((value) => value == null
          ? SigninWithGoogleState.cancel
          : SigninWithGoogleState.determined);
    } else {
      analytics.logEvent(name: "signin_sheet_link_with_google");
      return callLinkWithGoogle(_userService);
    }
  }

  handleException(Object exception) {
    state = state.copyWith(exception: exception);
  }

  showHUD() {
    state = state.copyWith(isLoading: true);
  }

  hideHUD() {
    state = state.copyWith(isLoading: false);
  }
}

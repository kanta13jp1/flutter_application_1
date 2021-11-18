import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/auth/apple.dart';
import 'package:flutter_application_1/auth/google.dart';
import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/components/page/hud.dart';
import 'package:flutter_application_1/entity/link_account_type.dart';
import 'package:flutter_application_1/entity/user_error.dart';
import 'package:flutter_application_1/error/error_alert.dart';
import 'package:flutter_application_1/error/universal_error_page.dart';
import 'package:flutter_application_1/signin/signin_sheet_state.dart';
import 'package:flutter_application_1/signin/signin_sheet_store.dart';

abstract class SigninSheetConst {
  static final double height = 340;
}

class SigninSheet extends HookWidget {
  final SigninSheetStateContext stateContext;
  final Function(LinkAccountType) callback;

  SigninSheet({
    required this.stateContext,
    required this.callback,
  });
  @override
  Widget build(BuildContext context) {
    final store = useProvider(signinSheetStoreProvider(stateContext));
    final state = useProvider(signinSheetStoreProvider(stateContext).state);
    return HUD(
      shown: state.isLoading,
      child: UniversalErrorPage(
        error: state.exception,
        reload: () => store.reset(),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 333,
            minHeight: 300,
            minWidth: MediaQuery.of(context).size.width,
          ),
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 14),
                  SvgPicture.asset("images/draggable_bar.svg", height: 6),
                  SizedBox(height: 24),
                  Text(state.title,
                      textAlign: TextAlign.center,
                      style: TextColorStyle.main.merge(FontType.sBigTitle)),
                  SizedBox(height: 16),
                  Text(state.message,
                      textAlign: TextAlign.center,
                      style: TextColorStyle.main.merge(FontType.assisting)),
                  SizedBox(height: 24),
                  _appleButton(context, store, state),
                  SizedBox(height: 24),
                  _googleButton(context, store, state),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appleButton(
    BuildContext context,
    SigninSheetStore store,
    SigninSheetState state,
  ) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(PilllColors.appleBlack),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      onPressed: () async {
        analytics.logEvent(name: "signin_sheet_selected_apple");
        store.showHUD();
        try {
          final signinState = await store.handleApple();
          switch (signinState) {
            case SigninWithAppleState.determined:
              Navigator.of(context).pop();
              callback(LinkAccountType.apple);
              return;
            case SigninWithAppleState.cancel:
              return;
          }
        } catch (error) {
          if (error is UserDisplayedError) {
            showErrorAlertWithError(context, error);
          } else {
            store.handleException(error);
          }
        } finally {
          store.hideHUD();
        }
      },
      child: Container(
        height: 48,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset("images/apple_icon.svg"),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  state.appleButtonText,
                  style: FontType.subTitle.merge(TextColorStyle.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleButton(
    BuildContext context,
    SigninSheetStore store,
    SigninSheetState state,
  ) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: PilllColors.secondary),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      onPressed: () async {
        analytics.logEvent(name: "signin_sheet_selected_google");
        store.showHUD();
        try {
          final signinState = await store.handleGoogle();
          switch (signinState) {
            case SigninWithGoogleState.determined:
              Navigator.of(context).pop();
              callback(LinkAccountType.google);
              break;
            case SigninWithGoogleState.cancel:
              return;
          }
        } catch (error) {
          if (error is UserDisplayedError) {
            showErrorAlertWithError(context, error);
          } else {
            store.handleException(error);
          }
        } finally {
          store.hideHUD();
        }
      },
      child: Container(
        height: 48,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset("images/google_icon.svg"),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  state.googleButtonText,
                  style: FontType.subTitle.merge(TextColorStyle.main),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showSigninSheet(BuildContext context, SigninSheetStateContext stateContext,
    Function(LinkAccountType) callback) {
  analytics.setCurrentScreen(screenName: "SigninSheet");
  showModalBottomSheet(
    context: context,
    builder: (context) => SigninSheet(
      stateContext: stateContext,
      callback: callback,
    ),
    backgroundColor: Colors.transparent,
  );
}

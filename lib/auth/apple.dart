import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/auth/hash.dart';
import 'package:flutter_application_1/auth/link_value_container.dart';
import 'package:flutter_application_1/util/environment.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final appleProviderID = "apple.com";

enum SigninWithAppleState { determined, cancel }

Future<LinkValueContainer?> linkWithApple(User user) async {
  try {
    final rawNonce = generateNonce();
    final state = generateNonce();
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: Environment.siwaServiceIdentifier,
        redirectUri: Uri.parse(Environment.androidSiwaRedirectURL),
      ),
      nonce: sha256ofString(rawNonce).toString(),
      state: state,
    );
    print("appleCredential: $appleCredential");
    if (state != appleCredential.state) {
      throw AssertionError('state not matched!');
    }
    final email = appleCredential.email;
    final credential = OAuthProvider(appleProviderID).credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
      rawNonce: rawNonce,
    );
    final linkedCredential = await user.linkWithCredential(credential);
    return Future.value(LinkValueContainer(linkedCredential, email));
  } on SignInWithAppleAuthorizationException catch (e) {
    if (e.code == AuthorizationErrorCode.canceled) {
      return Future.value(null);
    }
    rethrow;
  }
}

Future<UserCredential?> signInWithApple() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw FormatException("Anonymous User not found");
  }
  try {
    final rawNonce = generateNonce();
    final state = generateNonce();
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: Environment.siwaServiceIdentifier,
        redirectUri: Uri.parse(Environment.androidSiwaRedirectURL),
      ),
      nonce: sha256ofString(rawNonce).toString(),
      state: state,
    );
    print("appleCredential: $appleCredential");
    if (state != appleCredential.state) {
      throw AssertionError('state not matched!');
    }
    final credential = OAuthProvider(appleProviderID).credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
      rawNonce: rawNonce,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on SignInWithAppleAuthorizationException catch (e) {
    if (e.code == AuthorizationErrorCode.canceled) {
      return Future.value(null);
    }
    rethrow;
  }
}

bool isLinkedApple() {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return false;
  }
  return isLinkedAppleFor(user);
}

bool isLinkedAppleFor(User user) {
  return user.providerData
      .where((element) => element.providerId == appleProviderID)
      .isNotEmpty;
}

Future<bool> appleReauthentification() async {
  final rawNonce = generateNonce();
  final state = generateNonce();
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [AppleIDAuthorizationScopes.email],
    webAuthenticationOptions: WebAuthenticationOptions(
      clientId: Environment.siwaServiceIdentifier,
      redirectUri: Uri.parse(Environment.androidSiwaRedirectURL),
    ),
    nonce: sha256ofString(rawNonce).toString(),
    state: state,
  );
  print("appleCredential: $appleCredential");
  if (state != appleCredential.state) {
    throw AssertionError('state not matched!');
  }
  final credential = OAuthProvider(appleProviderID).credential(
    idToken: appleCredential.identityToken,
    accessToken: appleCredential.authorizationCode,
    rawNonce: rawNonce,
  );

  await FirebaseAuth.instance.currentUser
      ?.reauthenticateWithCredential(credential);
  return true;
}

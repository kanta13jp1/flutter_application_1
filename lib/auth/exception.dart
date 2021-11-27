import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/entity/link_account_type.dart';
import 'package:flutter_application_1/entity/user_error.dart';

Exception? mapFromFirebaseAuthException(
    FirebaseAuthException e, LinkAccountType accountType) {
  if (e.code == "provider-already-linked")
    throw UserDisplayedError(
        "この${accountType.providerName}はすにでお使いのPilllのアカウントに紐付いています。画面の更新をお試しください。FAQもご覧ください。詳細: ${e.message}",
        faqLinkURL:
            "https://pilll.wraptas.site/a8d3c745e58c40f0b8b771bb70f7a7d1");
  if (e.code == "credential-already-in-use")
    throw UserDisplayedError(
        "この${accountType.providerName}はすでに他のPilllのアカウントに紐付いているため登録ができません。FAQもご覧ください。詳細: ${e.message}",
        faqLinkURL:
            "https://pilll.wraptas.site/a8d3c745e58c40f0b8b771bb70f7a7d1");
  if (e.code == "email-already-in-use")
    throw UserDisplayedError(
        "すでに${accountType.providerName}でお使いのメールアドレスが他のPilllアカウントに紐付いているため登録ができません。FAQもご覧ください。詳細: ${e.message}");
  return null;
}

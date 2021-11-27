import 'package:flutter_application_1/components/atoms/buttons.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/entity/user_error.dart';
import 'package:url_launcher/url_launcher.dart';

class ErrorAlert extends StatelessWidget {
  final String? title;
  final String errorMessage;
  final String? faqLinkURL;

  const ErrorAlert(
      {Key? key, this.title, this.faqLinkURL, required this.errorMessage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final faq = this.faqLinkURL;
    return AlertDialog(
      title: Text(
        title ?? "エラーが発生しました",
        style: FontType.subTitle.merge(TextColorStyle.black),
      ),
      content: Text(errorMessage,
          style: FontType.assisting.merge(TextColorStyle.black)),
      actions: <Widget>[
        if (faq != null)
          AlertButton(
            text: "FAQを見る",
            onPressed: () {
              launch(faq);
            },
          ),
        AlertButton(
          text: "閉じる",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

void showErrorAlert(BuildContext context,
    {String? title, required String message}) {
  showDialog(
    context: context,
    builder: (_) {
      return ErrorAlert(
        title: title,
        errorMessage: message,
      );
    },
  );
}

void showErrorAlertWithError(BuildContext context, UserDisplayedError error) {
  showDialog(
    context: context,
    builder: (_) {
      return ErrorAlert(
        title: error.title ?? "エラーが発生しました",
        errorMessage: error.toString(),
        faqLinkURL: error.faqLinkURL,
      );
    },
  );
}

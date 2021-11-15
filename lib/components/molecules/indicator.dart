import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/environment.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Environment.disableWidgetAnimation) {
      return Center(
        child: Container(
          color: PilllColors.primary,
          width: 40,
          height: 40,
        ),
      );
    }
    return Container(
      child: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(PilllColors.primary)),
      ),
    );
  }
}

class ScaffoldIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PilllColors.background,
      body: Indicator(),
    );
  }
}

class DialogIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: PilllColors.modalBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 200,
          height: 200,
          child: Indicator(),
        ),
      ),
    );
  }
}

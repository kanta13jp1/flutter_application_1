import 'package:flutter/material.dart';

import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';

class PremiumBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
      decoration: BoxDecoration(
        color: PilllColors.gold,
        borderRadius: BorderRadius.circular(41),
      ),
      child: Text("Premium",
          style: TextStyle(
            color: TextColor.white,
            fontFamily: FontFamily.number,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          )),
    );
  }
}

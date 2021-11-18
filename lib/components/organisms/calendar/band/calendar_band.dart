import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/atoms/font.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/components/molecules/diagonal_striped_line.dart';

import 'calendar_band_model.dart';

abstract class CalendarBandConst {
  static const double height = 13;
}

class CalendarBand extends StatelessWidget {
  const CalendarBand({
    Key? key,
    required this.model,
    required this.isLineBreaked,
    required this.width,
    this.onTap,
  }) : super(key: key);

  final CalendarBandModel model;
  final bool isLineBreaked;
  final double width;
  final Function(CalendarBandModel)? onTap;

  @override
  Widget build(BuildContext context) {
    final onTap = this.onTap;
    return GestureDetector(
      onTap: () => onTap != null ? onTap(model) : null,
      child: Container(
        height: CalendarBandConst.height,
        child: Stack(
          children: [
            CustomPaint(
              painter: DiagonalStripedLine(
                  color: model.color,
                  isNecessaryBorder: model.isNecessaryBorder),
              size: Size(width, CalendarBandConst.height),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(isLineBreaked ? "" : model.label,
                  style: FontType.sSmallTitle.merge(TextColorStyle.white)),
            ),
          ],
        ),
      ),
    );
  }
}

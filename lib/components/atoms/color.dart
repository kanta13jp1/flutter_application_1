import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHex({required Color color, bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${color.alpha.toRadixString(16).padLeft(2, '0')}'
      '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}';
}

class PilllColors {
  const PilllColors();

  static final Color primary = HexColor.fromHex("E56A45");
  static final Color secondary = HexColor.fromHex("4E6287");
  static final Color calendarHeader = HexColor.fromHex("B9D7F1");
  static final Color accent = Colors.white;
  static final Color pillSheet = HexColor.fromHex("E8EBED");
  static final Color mat = HexColor.fromHex("FAFAFA").withAlpha(80);
  static final Color sunday = HexColor.fromHex("E17F7F");
  static final Color saturday = HexColor.fromHex("7FB9E1");
  static final Color weekday = HexColor.fromHex("7E7E7E");
  static final Color enable = HexColor.fromHex('E56A45');
  static final Color disable = HexColor.fromHex("EAEAEA");
  static final Color divider = HexColor.fromHex("9DAFBD");

  static final Color bottomBar = HexColor.fromHex("FAFAFA");
  static final Color border = HexColor.fromHex("DADADA");
  static final Color unselect = HexColor.fromHex("DFDFDF");
  static final Color background = HexColor.fromHex("F6F9FB");
  static final Color blueBackground = HexColor.fromHex("F1F2F5");

  static final Color blank = Colors.white;
  static final Color black = HexColor.fromHex("333333");
  static final Color red = HexColor.fromHex("EB5757");
  static final Color potti = HexColor.fromHex("7C8E9C");
  static final Color lightGray = HexColor.fromHex("CDCFD1");
  static final Color gray = HexColor.fromHex("BEC0C2");
  static final Color gold = HexColor.fromHex("B29446");

  static final Color menstruation = HexColor.fromHex("E3BFC2");
  static final Color duration = HexColor.fromHex("6A7DA5");
  static final Color overlay = primary.withAlpha(20);

  static final Color modalBackground =
      HexColor.fromHex("333333").withAlpha((255 * 0.7).round());
  static final Color white = Colors.white;

  static Color get disabledSheet => PilllColors.pillSheet;
  static final Color thinSecondary = HexColor.fromHex("4E6287").withAlpha(20);
  static final Color shadow = HexColor.fromHex("212121").withOpacity(0.14);
  static final Color tinBackground =
      HexColor.fromHex("212121").withOpacity(0.08);

  static final Color appleBlack = HexColor.fromHex("231815");
}

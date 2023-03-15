import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xFF3386D4);
  static const Color green = Color(0xFF96D253);
  static const Color lightPrimary = Color(0xFF55c0F8);
  static const Color black = Color(0xFF000000);
  static const Color grey = Colors.grey;
  static const Color white = Color(0xFFFAFAFA);
  static const Color lightGrey = Color.fromARGB(255, 219, 217, 217);
  static const Color lightGrey1 = Color(0xFFF7F7F7);
  static const Color secondary = Color(0xFFEEAA49);
  static const Color yellow = Color(0xFFEBD65F);
  static const Color error = Color(0xFFe61f32);
  static const Color transparentRed = Color(0xFFFBEBEB);
  static const Color favRed = Color(0xFFC35B57);

}

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

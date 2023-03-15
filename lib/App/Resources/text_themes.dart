import 'package:flutter/material.dart';

TextStyle _getStyle(
  double fontSize,
  FontWeight fontWeight,
  Color fontColor,
) {
  return TextStyle(
    fontFamily: "Tajawal",
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: fontColor,
  );
}

//Regular style
TextStyle getRegularStyle({
  double fontSize = 14,
  Color fontColor = Colors.black,
}) {
  return _getStyle(
    fontSize,
    FontWeight.normal,
    fontColor,
  );
}

//Medium style
TextStyle getMediumStyle({
  double fontSize = 13,
  Color fontColor = Colors.black,
}) {
  return _getStyle(
    fontSize,
    FontWeight.normal,
    fontColor,
  );
}

//Semi-bold style
TextStyle getSemiBoldStyle({
  double fontSize = 14,
  Color fontColor = Colors.grey,
}) {
  return _getStyle(
    fontSize,
    FontWeight.w600,
    fontColor,
  );
}

//Bold style
TextStyle getBoldStyle({
  double size = 16,
  Color fontColor = Colors.black,
}) {
  return _getStyle(
    size,
    FontWeight.bold,
    fontColor,
  );
}

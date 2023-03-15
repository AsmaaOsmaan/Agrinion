import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main app colors

    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    disabledColor: ColorManager.lightGrey,
    splashColor: ColorManager.lightPrimary,
    fontFamily: "Tajawal",
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorManager.black),
    scaffoldBackgroundColor: Colors.white,
    //app bar theme
    appBarTheme: AppBarTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.lightPrimary,
      elevation: 0,
      toolbarHeight: 60,
      titleTextStyle: getBoldStyle(
        size: 20,
      ),
      iconTheme: const IconThemeData(color: ColorManager.black),
    ),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        color: ColorManager.lightPrimary,
        borderRadius: BorderRadius.circular(5),
      ),
      labelStyle: getBoldStyle(),
    ),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(fontColor: Colors.white),
        elevation: 0,
        primary: ColorManager.primary,
        shape: const StadiumBorder(),
      ),
    ),

    //text theme
    textTheme: TextTheme(
      headline1: getSemiBoldStyle(fontSize: 16, fontColor: ColorManager.black),
      subtitle1: getMediumStyle(fontSize: 16, fontColor: ColorManager.black),
      bodyText1: getRegularStyle(fontSize: 16, fontColor: ColorManager.grey),
    ),

    //input decoration theme -> text form field
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),

      //hint style
      hintStyle: getRegularStyle(fontColor: ColorManager.grey),

      //label style
      labelStyle: getMediumStyle(),

      //error style
      errorStyle: getRegularStyle(fontColor: ColorManager.error),

      //enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1.5, color: ColorManager.lightGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      // disabledBorder
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1.5, color: ColorManager.lightGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      //focused border
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1.5, color: ColorManager.primary),
        borderRadius: BorderRadius.circular(8),
      ),

      //error border
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1.5, color: ColorManager.error),
        borderRadius: BorderRadius.circular(8),
      ),

      //focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(width: 1.5, color: ColorManager.lightPrimary),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

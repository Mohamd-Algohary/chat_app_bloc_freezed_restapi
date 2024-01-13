import 'package:flutter/material.dart';

import '/presentation/resources/styles_manger.dart';
import 'colors_manager.dart';
import 'fonts_manager.dart';
import 'values_manger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    //!main colors
    primaryColor: ColorManager.primaryColor,
    // primaryColorLight: ColorManager.lightPrimary,
    // primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey,
    splashColor: ColorManager.lightTeal,
    //!card view theme
    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4),
    //!app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.teal,
        shadowColor: ColorManager.lightTeal,
        elevation: AppSize.s4,
        titleTextStyle: getRegularTextStyle(
            fontSize: FontSize.s16, color: ColorManager.white)),
    //!button theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        buttonColor: ColorManager.teal,
        splashColor: ColorManager.lightTeal,
        disabledColor: ColorManager.grey),
    //! elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularTextStyle(
                fontSize: FontSize.s17, color: ColorManager.white),
            backgroundColor: ColorManager.teal,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),
    //!text theme
    textTheme: TextTheme(
        headlineLarge: getSemiBoldTextStyle(
            fontSize: FontSize.s32, color: ColorManager.white),
        headlineMedium: getMeduimTextStyle(
            fontSize: FontSize.s24, color: ColorManager.white),
        headlineSmall: getRegularTextStyle(color: ColorManager.white),
        labelLarge: getRegularTextStyle(color: ColorManager.mintGray),
        labelMedium: getMeduimTextStyle(
            fontSize: FontSize.s12, color: ColorManager.teal),
        labelSmall: getSemiBoldTextStyle(
            fontSize: FontSize.s16, color: ColorManager.teal),
        titleLarge: getMeduimTextStyle(
            fontSize: FontSize.s16, color: ColorManager.white),
        titleMedium: getMeduimTextStyle(
            fontSize: FontSize.s14, color: ColorManager.grey),
        titleSmall: getMeduimTextStyle(
            fontSize: FontSize.s14, color: ColorManager.grey),
        bodyLarge:
            getBoldTextStyle(color: ColorManager.teal, fontSize: FontSize.s12),
        bodySmall: getRegularTextStyle(color: ColorManager.grey)),

    //!Input decoration theme(text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularTextStyle(
          fontSize: FontSize.s14, color: ColorManager.white),
      labelStyle:
          getMeduimTextStyle(fontSize: FontSize.s14, color: ColorManager.grey),
      errorStyle: getRegularTextStyle(
          fontSize: FontSize.s14, color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.teal, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.teal, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
    ),
  );
}

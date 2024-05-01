import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

/// All custom application theme
class AppTheme {
  // Default application theme
  final ThemeData _themeLight = ThemeData.light();

  ThemeData get themeLight => _themeLight.copyWith(
        primaryColor: ColorApp.mainColor,
        buttonTheme: buttonThemeData,
        buttonBarTheme: _themeLight.buttonBarTheme.copyWith(
          buttonTextTheme: ButtonTextTheme.accent,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorApp.mainColor,
          iconTheme: IconThemeData(color: ColorApp.secondaryColor),
          titleTextStyle:   TextStyle(color: ColorApp.secondaryColor,fontSize: 22,fontWeight: FontWeight.w600,fontFamily: "Myanmar")
        ),
        cardTheme: const CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
           fillColor: ColorApp.bgColorGrey,
                    filled: true,
                      border:OutlineInputBorder(
                      borderSide: BorderSide(color: ColorApp.bgColorGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                      enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: ColorApp.bgColorGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                        errorBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: ColorApp.lipstick),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    hintStyle: TextStyle(
                      fontSize: 20,
                        fontWeight: FontWeight.w500, fontFamily: "Myanmar")
        ),
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        textTheme: getTextTheme(_themeLight.primaryTextTheme),
        primaryTextTheme: getTextTheme(_themeLight.primaryTextTheme).apply(
          bodyColor: ColorApp.mainColor,
          displayColor: ColorApp.mainColor,
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: ColorApp.mainColor)
            .copyWith(
              error: Colors.red[400],
            ),
      );
}

TextTheme getTextTheme(TextTheme theme) {
  var baseTextColor = Colors.black;

  return theme.copyWith(
    displayLarge: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        fontFamily: "Myanmar",
        color: baseTextColor),
    displayMedium: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        fontFamily: "Myanmar",
        letterSpacing: -0.5,
        color: baseTextColor),
    displaySmall: TextStyle(
        fontFamily: "Myanmar",
        fontSize: 48, fontWeight: FontWeight.w400, color: baseTextColor),
    headlineMedium: TextStyle(
        fontFamily: "Myanmar",
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: baseTextColor),
    headlineSmall: TextStyle(
        fontFamily: "Myanmar",
        fontSize: 24, fontWeight: FontWeight.w400, color: baseTextColor),
    titleLarge: TextStyle(
        fontSize: 21,
        fontFamily: "Myanmar",
        fontWeight: FontWeight.w500,
        letterSpacing: 0.52,
        color:baseTextColor),
    titleMedium: TextStyle(
        fontFamily: "Myanmar",
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: baseTextColor),
    titleSmall: TextStyle(
        fontSize: 14,
        fontFamily: "Myanmar",
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: baseTextColor),
    bodyMedium: TextStyle(
        fontFamily: "Myanmar",
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: baseTextColor),
    bodyLarge: TextStyle(
        fontFamily: "Myanmar",
        fontSize: 16,
        fontWeight: FontWeight.w700,
        
        color: baseTextColor),
    labelLarge: TextStyle(
        fontFamily: "Myanmar",
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: baseTextColor),
    bodySmall: TextStyle(
        fontFamily: "Myanmar",
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: baseTextColor),
    labelSmall: TextStyle(
        fontFamily: "Myanmar",
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        color: baseTextColor),
  );
}

const ButtonThemeData buttonThemeData = ButtonThemeData(
  height: 50,
  buttonColor: Colors.blueAccent,
  textTheme: ButtonTextTheme.primary,
);

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pst_online/app/core/values/color.dart';
import 'package:pst_online/app/core/values/size.dart';
import 'package:pst_online/app/core/values/style.dart';

final kThemeLight = ThemeData.light().copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: kColorPrimary,
    onPrimary: kColorNeutral10,
    secondary: kColorSecondary,
    onSecondary: kColorNeutral10,
    error: kColorError,
    onError: kColorNeutral10,
    background: kColorNeutral10,
    onBackground: kColorNeutral90,
    surface: kColorNeutral20,
    onSurface: kColorNeutral20,
  ),
  scaffoldBackgroundColor: kColorNeutral20,
  dividerColor: kColorNeutral30,
  disabledColor: kColorNeutral50,
  inputDecorationTheme: InputDecorationTheme(
    alignLabelWithHint: true,
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: kColorNeutral50,
      ),
    ),

    contentPadding: kPadding16H8V,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: kColorNeutral50,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: kColorErrorBorder,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: kColorNeutral40,
      ),
    ),
    errorStyle: kTextStyleCaption.copyWith(
      color: kColorErrorSurface,
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: kColorPrimary,
      ),
    ),
    labelStyle: kTextStyleBody2.copyWith(
      fontWeight: FontWeight.w600,
    ),
    hintStyle: kTextStyleBody2.copyWith(
      color: kColorNeutral50,
    ),
    floatingLabelStyle: kTextStyleBody2.copyWith(
      color: kColorPrimary,
      fontWeight: FontWeight.w600,
    )
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: kColorPrimaryPressed,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    )
  ),
  textTheme: TextTheme(
    headline1: kTextStyleTitle1,
    headline2: kTextStyleTitle2,
    headline3: kTextStyleTitle3,
    headline4: kTextStyleTitle4,
    headline5: kTextStyleTitle5,
    headline6: kTextStyleTitle6,
    bodyText1: kTextStyleBody1,
    bodyText2: kTextStyleBody2,
    caption: kTextStyleCaption,
  ),
  backgroundColor: kColorNeutral10,
  dividerTheme: const DividerThemeData(
    color: kColorNeutral40,
  ),
);

final kThemeDark = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0.0,
  ),
  textTheme: TextTheme(
    headline1: kTextStyleTitle1,
    headline2: kTextStyleTitle2,
    headline3: kTextStyleTitle3,
    headline4: kTextStyleTitle4,
    headline5: kTextStyleTitle5,
    headline6: kTextStyleTitle6,
    bodyText1: kTextStyleBody1,
    bodyText2: kTextStyleBody2,
    caption: kTextStyleCaption,
  ),
);

import 'package:flutter/material.dart';
import 'package:pst_online/app/core/values/color.dart';

ThemeData getTheme(Brightness mode, bool isUseMaterial3) =>
    mode == Brightness.light
        ? ThemeData(
            colorScheme: lightColorScheme,
            primaryColor: lightColorScheme.primary,
            primaryColorLight: Color.alphaBlend(
              Colors.white.withAlpha(0x66),
              lightColorScheme.primary,
            ),
            primaryColorDark: Color.alphaBlend(
              Colors.black.withAlpha(0x66),
              lightColorScheme.primary,
            ),
            secondaryHeaderColor: Color.alphaBlend(
              Colors.white.withAlpha(0xCC),
              lightColorScheme.primary,
            ),
            toggleableActiveColor: isUseMaterial3
                ? lightColorScheme.onSurface
                : lightColorScheme.onPrimary,
            scaffoldBackgroundColor: lightColorScheme.background,
            canvasColor: lightColorScheme.background,
            backgroundColor: lightColorScheme.background,
            cardColor: lightColorScheme.surface,
            bottomAppBarColor: lightColorScheme.surface,
            dialogBackgroundColor: lightColorScheme.surface,
            indicatorColor: isUseMaterial3
                ? lightColorScheme.onSurface
                : lightColorScheme.onPrimary,
            dividerColor: lightColorScheme.onSurface.withOpacity(0.12),
            errorColor: lightColorScheme.error,
            applyElevationOverlayColor: true,
            useMaterial3: isUseMaterial3,
            visualDensity: VisualDensity.standard,
            tabBarTheme: TabBarTheme(
              labelColor: isUseMaterial3
                  ? lightColorScheme.onSurface
                  : lightColorScheme.onPrimary,
            ),
            appBarTheme: AppBarTheme(
              shadowColor: lightColorScheme.shadow,
            ),
          )
        : ThemeData(
            colorScheme: darkColorScheme,
            primaryColor: darkColorScheme.primary,
            primaryColorLight: Color.alphaBlend(
              Colors.white.withAlpha(0x59),
              darkColorScheme.primary,
            ),
            primaryColorDark: Color.alphaBlend(
              Colors.black.withAlpha(0x72),
              darkColorScheme.primary,
            ),
            secondaryHeaderColor: Color.alphaBlend(
              Colors.black.withAlpha(0x99),
              darkColorScheme.primary,
            ),
            toggleableActiveColor: isUseMaterial3
                ? darkColorScheme.primary
                : darkColorScheme.secondary,
            scaffoldBackgroundColor: darkColorScheme.background,
            canvasColor: darkColorScheme.background,
            backgroundColor: darkColorScheme.background,
            cardColor: darkColorScheme.surface,
            bottomAppBarColor: darkColorScheme.surface,
            dialogBackgroundColor: darkColorScheme.surface,
            indicatorColor: darkColorScheme.onSurface,
            dividerColor: darkColorScheme.onSurface.withOpacity(0.12),
            errorColor: darkColorScheme.error,
            applyElevationOverlayColor: true,
            useMaterial3: isUseMaterial3,
            visualDensity: VisualDensity.standard,
            tabBarTheme: TabBarTheme(
              labelColor: darkColorScheme.onSurface,
            ),
            appBarTheme: AppBarTheme(
              shadowColor: darkColorScheme.shadow,
            ),
          );

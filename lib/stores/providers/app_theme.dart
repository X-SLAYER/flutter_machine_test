// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/shared_prefences.dart';
import '../../constant/styles.dart';
import '../../data/locale/shared_prefs_handler.dart';

enum ThemeStyle { dark, light }

class AppTheme extends ChangeNotifier {
  ThemeStyle themeType = ThemeStyle.light;
  bool get isDarkTheme => themeType == ThemeStyle.dark;
  ThemeData get getThemeData =>
      themeType == ThemeStyle.light ? themeData : darkTheme;

  void setThemeData(ThemeStyle val) {
    themeType = val;
    notifyListeners();
  }

  void setThemeDataFromSystem() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    setThemeData(
      brightness == Brightness.dark ? ThemeStyle.dark : ThemeStyle.light,
    );
  }

  void toggleTheme() {
    setThemeData(
      themeType == ThemeStyle.light ? ThemeStyle.dark : ThemeStyle.light,
    );
    SharedPrefsHandler.storeValue(SharedPrefsKeys.appTheme, themeType.name);
  }

  final ThemeData themeData = ThemeData(
    useMaterial3: true,
    tabBarTheme: const TabBarThemeData(
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    brightness: Brightness.light,
    primaryColor: const Color.fromRGBO(0, 68, 105, 1),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      color: Color(0xFFD73556),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      scrolledUnderElevation: 0,
      centerTitle: false,
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: $styles.colors.textColor),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: $styles.colors.textColor, fontSize: 12.0),
      bodyMedium: TextStyle(
        color: $styles.colors.textColor,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
      bodyLarge: TextStyle(
        color: $styles.colors.textColor,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
      titleSmall: TextStyle(
        color: $styles.colors.textColor,
        fontSize: 14.0,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      titleMedium: TextStyle(
        color: $styles.colors.textColor,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      titleLarge: TextStyle(
        color: $styles.colors.textColor,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context) =>
          const Icon(Icons.arrow_back_ios, color: Colors.white),
    ),
    cardColor: $styles.colors.softPink,
    colorScheme: ColorScheme.fromSeed(
      seedColor: $styles.colors.accent1,
      primary: $styles.colors.accent1,
      primaryContainer: const Color(0xFFdf5267),
      secondary: $styles.colors.accent2,
      surface: Colors.white,
      background: const Color(0xFFF9F7F5),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    tabBarTheme: const TabBarThemeData(
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    brightness: Brightness.dark,
    primaryColor: $styles.colors.accent1,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      color: Color(0xFFD73556),
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: $styles.colors.white, fontSize: 12.0),
      bodyMedium: TextStyle(
        color: $styles.colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
      bodyLarge: TextStyle(
        color: $styles.colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
      titleSmall: TextStyle(
        color: $styles.colors.white,
        fontSize: 14.0,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      titleMedium: TextStyle(
        color: $styles.colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      titleLarge: TextStyle(
        color: $styles.colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context) =>
          Icon(Icons.arrow_back_ios, color: $styles.colors.white),
    ),
    cardColor: const Color(0xFF282828),
    colorScheme: ColorScheme.fromSeed(
      seedColor: $styles.colors.accent1,
      primaryContainer: const Color(0xFFdf5267),
      primary: $styles.colors.accent1,
      secondary: $styles.colors.accent1,
      surface: const Color(0xFF121212),
      background: const Color(0xFF121212),
      brightness: Brightness.dark,
    ),
  );
}

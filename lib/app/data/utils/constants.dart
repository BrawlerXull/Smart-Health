import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  // Name
  static String appName = "Rhinestone";

  // Material Design Color
  static const Color lightPrimary = Color(0xfffcfcff);
  static const Color lightAccent = Color(0xFF3B72FF);
  static const Color lightBackground = Color(0xfffcfcff);

  static const Color darkPrimary = Colors.black;
  static const Color darkAccent = Color(0xFF3B72FF);
  static const Color darkBackground = Colors.black;

  static const Color grey = Color(0xff707070);
  static const Color textPrimary = Color(0xFF486581);
  static const Color textDark = Color(0xFF102A43);

  static const Color backgroundColor = Color(0xFFF5F5F7);

  // Green
  static const Color darkGreen = Color(0xFF3ABD6F);
  static const Color lightGreen = Color(0xFFA1ECBF);

  // Yellow
  static const Color darkYellow = Color(0xFF3ABD6F);
  static const Color lightYellow = Color(0xFFFFDA7A);

  // Blue
  static const Color darkBlue = Color(0xFF3B72FF);
  static const Color lightBlue = Color(0xFF3EC6FF);

  // Orange
  static const Color darkOrange = Color(0xFFFFB74D);

  static ThemeData lightTheme(BuildContext context) {
    final base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: lightBackground,
      colorScheme: base.colorScheme.copyWith(
        primary: lightPrimary,
        secondary: lightAccent,
        background: lightBackground,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: lightAccent,
      ),
      textTheme: GoogleFonts.latoTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackground,
        iconTheme: IconThemeData(color: lightAccent),
        elevation: 0,
      ),
    );
  }

  static const double headerHeight = 228.5;
  static const double paddingSide = 30.0;
}

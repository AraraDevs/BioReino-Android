import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class BRTheme {
  static final TextTheme _textTheme = TextTheme(
    titleMedium: TextStyle(
      fontFamily: GoogleFonts.catamaran().fontFamily,
      fontWeight: FontWeight.w600,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(color: BRColors.blackDark),
    scaffoldBackgroundColor: BRColors.blackDark,
  );

  static final ThemeData lightTheme = ThemeData(
    textTheme: _textTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      foregroundColor: BRColors.greyText,
    ),
  );
}

abstract class BRColors {
  static Color greenYellow = const Color(0xFFB0D606);
  static Color greenDark = const Color(0xFF36A32C);
  static Color greenLightBlue = const Color(0xFF26DA77);
  static Color greenLight = const Color(0xFF60DD56);
  static Color green = const Color(0xFF0EB301);

  static Color yellow = const Color(0xFFECCD00);

  static Color blue = const Color(0xFF09BDDD);
  static Color blueGreen = const Color(0xFF0BD4BC);

  static Color orangeRed = const Color(0xFFF54725);
  static Color orange = const Color(0xFFEB7817);

  static Color greyText = const Color(0xFF737373);
  static Color blackDark = const Color(0xFF0E1013);
}

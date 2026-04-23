part of 'themes.dart';

ThemeData get _light => ThemeData
(
  primaryColor: constants.Colors.lightPrimary,   // اللون الأساسي
  useMaterial3: true,
  fontFamily: 'Cairo',
  colorScheme: ColorScheme.fromSwatch
  (
    primarySwatch: Colors.blue,                          // لوحة الألوان
    accentColor: constants.Colors.lightAccent,   // اللون الثانوي
  ),

  scaffoldBackgroundColor: constants.Colors.lightBackground,
  appBarTheme: AppBarTheme
  (
    backgroundColor: constants.Colors.lightPrimary,
    foregroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,                                         // إزالة الظل
  ),

  textTheme: const TextTheme
  (
    headlineLarge: TextStyle
    (
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    headlineMedium: TextStyle
    (
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    headlineSmall: TextStyle
    (
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    bodyLarge: TextStyle
    (
      fontSize: 16,
      color: Colors.black87,
    ),

    bodyMedium: TextStyle
    (
      fontSize: 14,
      color: Colors.black54,
    ),

    bodySmall: TextStyle
    (
      fontSize: 12,
      color: Colors.black38,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme
  (
    border: OutlineInputBorder
    (
      borderRadius: BorderRadius.circular(8),            // زوايا مدورة
    ),
    filled: true,
    fillColor: Colors.white,
  ),

  buttonTheme: ButtonThemeData
  (
    shape: RoundedRectangleBorder
    (
      borderRadius: BorderRadius.circular(8),
    ),
    
    buttonColor: constants.Colors.lightPrimary,
  ),
);
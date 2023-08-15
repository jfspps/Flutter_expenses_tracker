import 'package:flutter/material.dart';

import 'package:expense_tracker/expenses.dart';

var kColourScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(
    255,
    146,
    92,
    220,
  ),
);

void main() {

  // the following colour schemes are used throughout this project; check for
  // null references when applying them
  var kAppBarTheme = const AppBarTheme().copyWith(
    backgroundColor: kColourScheme.onPrimaryContainer,
    foregroundColor: kColourScheme.primaryContainer,
  );

  var kCardTheme = const CardTheme().copyWith(
    color: kColourScheme.secondaryContainer,
  );

  var kElevatedButtonTheme = ElevatedButtonThemeData(
    // note that styleFrom is roughly equivalent to copyWith in regard to
    // applying defaults and overriding a select few (styles and themes have
    // changed quite a bit and some calls are deprecated)
    style: ElevatedButton.styleFrom(
      backgroundColor: kColourScheme.primaryContainer,
    ),
  );

  var kTextTheme = const TextTheme().copyWith(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: kColourScheme.onPrimary,
      fontSize: 18,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.normal,
      color: kColourScheme.onSecondaryContainer,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.normal,
      color: kColourScheme.primary,
    )
  );

  runApp(
    MaterialApp(
      // force use of matching colours for AppBar and  Scaffold
      // at this time, Material2 renders a blue coloured AppBar;
      // furthermore, copy the defaults and override select options
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColourScheme,
        appBarTheme: kAppBarTheme,
        cardTheme: kCardTheme,
        elevatedButtonTheme: kElevatedButtonTheme,
        textTheme: kTextTheme,
      ),
      home: const Expenses(),
    ),
  );
}

import 'package:flutter/material.dart';

import 'package:expense_tracker/expenses.dart';
import 'package:flutter/services.dart';

var kColourScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(
    255,
    146,
    92,
    220,
  ),
);

void main() {
  // make sure required widgets are initialised before setting preferred orientation
  WidgetsFlutterBinding.ensureInitialized();

  // using flutter/services.dart, set the preferred orientation if apps are
  // allowed to adjust (responsive); this is future which then requires a call to
  // then() after the device orientation is locked at the time
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then(
    // function is available but not called here
    (function) {
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
          ));

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
    },
  );
}

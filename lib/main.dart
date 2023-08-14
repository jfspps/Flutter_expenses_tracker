
import 'package:flutter/material.dart';

import 'package:expense_tracker/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      // force use of matching colours for AppBar and  Scaffold
      // at this time, Material2 renders a blue coloured AppBar
      theme: ThemeData(useMaterial3: true),
      home: const Expenses(),
    ),
  );
}

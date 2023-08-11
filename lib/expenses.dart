import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _dummyList = [
    Expense(
        title: "Movie",
        amount: 50,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: "Demo",
        amount: 140,
        date: DateTime.now(),
        category: Category.work),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text("Line 1"),
          Text("Line 2"),
        ],
      ),
    );
  }
}

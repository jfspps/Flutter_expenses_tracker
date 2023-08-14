import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
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
      category: Category.leisure,
    ),
    Expense(
      title: "Demo",
      amount: 140,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold has prebuilt widgets to manage the title bar and other commonly
    // used widgets
    return Scaffold(
      // AppBar takes care of space above the AppBar
      appBar: AppBar(
        title: const Text('Expenses tracking app'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              (Icons.add),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text(
            "Expenses so far...",
          ),
          Expanded(
            child: ExpensesList(
              expenses: _dummyList,
            ),
          ),
        ],
      ),
    );
  }
}

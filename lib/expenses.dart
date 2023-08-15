import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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
      category: ExpenseCategory.leisure,
    ),
    Expense(
      title: "Demo",
      amount: 140,
      date: DateTime.now(),
      category: ExpenseCategory.work,
    ),
  ];

  void _openAddExpenseOverlay() {
    // a modalBottomSheet receives temporary focus at the bottom of the screen,
    // greying out other widgets; to revert focus, the user clicks the greyed-out area;
    // the context stores metadata that relates this widget to all others in a
    // tree-like data structure; "context" below is global and is distinct from "ctx"
    // which is specific to the ModalBottomSheet widget
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

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
            onPressed: _openAddExpenseOverlay,
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

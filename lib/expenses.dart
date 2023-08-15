import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/foundation.dart';
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
  final List<Expense> expensesList = [];

  void _openAddExpenseOverlay() {
    // a modalBottomSheet receives temporary focus at the bottom of the screen,
    // greying out other widgets; to revert focus, the user clicks the greyed-out area;
    // the context stores metadata that relates this widget to all others in a
    // tree-like data structure; "context" below is global and is distinct from "ctx"
    // which is specific to the ModalBottomSheet widget
    showModalBottomSheet(
      context: context,
      // forces modal page to use entire page and can be scrolled close
      isScrollControlled: true,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      expensesList.add(expense);
      if (kDebugMode) {
        print(
          "Added expense: ${expense.title} dated ${expense.formattedDate}",
        );
      }
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      expensesList.remove(expense);
      if (kDebugMode) {
        print(
          "Removed expense: ${expense.title} dated ${expense.formattedDate}",
        );
      }

      // make sure all related snack bars are removed from the UI (users can swipe
      // multiple times)
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      // now inform the user and allow them to reverse the changes;
      // note that UNDO will change the order of the elements in the list
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(
            seconds: 2,
          ),
          content: const Text(
            'Expense item removed',
          ),
          action: SnackBarAction(label: 'UNDO', onPressed: () {
            setState(() {
              _addExpense(expense);
            });
          }),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget expensesListWidget = const Center(
      child: Text(
        'No expenses saved',
      ),
    );

    if (expensesList.isNotEmpty) {
      expensesListWidget = ExpensesList(
        expenses: expensesList,
        removeExpense: _removeExpense,
      );
    }

    // Scaffold has prebuilt widgets to manage the title bar and other commonly
    // used widgets
    return Scaffold(
      // AppBar takes care of space above the AppBar
      appBar: AppBar(
        title: const Text(
          'Expenses tracking app',
        ),
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
            child: expensesListWidget,
          ),
        ],
      ),
    );
  }
}

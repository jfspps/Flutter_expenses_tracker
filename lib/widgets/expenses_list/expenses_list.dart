import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.removeExpense
  });

  final List<Expense> expenses;

  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    // ListViews are scrollable by default; build a list based on the length
    // of expenses list, and access the title be index; note the ctx is a
    // reference to a different Context object
    return ListView.builder(
      itemCount: expenses.length,
      // allow expense items to be swiped away
      itemBuilder: (ctx, index) => Dismissible(
        // key is a unique identifier and requires another unique identifier
        // with ValueKey taking the index of the element
        key: ValueKey(expenses[index]),
        // need this to update the calling parent widget; the "direction" param
        // is ignored in this case but can be used to define functionality if
        // one were to swipe left or right
        onDismissed: (direction) => removeExpense(expenses[index]),
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}

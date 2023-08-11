import 'package:flutter/cupertino.dart';

import 'models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    // ListViews are scrollable by default; build a list based on the length
    // of expenses list, and access the title be index; note the ctx is a
    // reference to a different Context object
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Text(expenses[index].title),
    );
  }
}

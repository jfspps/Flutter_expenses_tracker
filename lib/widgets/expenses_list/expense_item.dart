import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 18,
        ),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  // ultimately trying to concatenate a pound symbol while also
                  // adhering to symbols used to insert values to a string;
                  // a $ symbol, unlike the £ symbol, would need to be escaped with \
                  '£${expense.amount.toStringAsFixed(2)}',
                ),
                // Spacer widgets use all space available between widgets defined
                // before and after the Spacer
                const Spacer(),
                // goal here is to group widgets under another row for UI purposes
                Row(
                  children: [
                    Icon(
                      categoryIcons[expense.category],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      // calling a getter without parenthesise
                      expense.formattedDate,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

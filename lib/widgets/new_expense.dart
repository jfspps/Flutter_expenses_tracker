import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // takes care of text input when the modal screen is required
  final _textInputController = TextEditingController();
  final _numericalInputController = TextEditingController();

  DateTime? _selectedDateTime;

  ExpenseCategory _selectedExpenseCategory = ExpenseCategory.work;

  // async indicates that some value will be assigned in the future (i.e. is of
  // the generic type Future<>
  void _presentDatePicker() async {
    final dateTimeNow = DateTime.now();
    final firstDateTime = DateTime(
      dateTimeNow.year - 1,
      dateTimeNow.month,
      dateTimeNow.day,
    );

    // this potentially null for the time-being
    final pickedDateTime = await showDatePicker(
      context: context,
      initialDate: dateTimeNow,
      firstDate: firstDateTime,
      lastDate: dateTimeNow,
    );

    // code from this point onwards will not execute until _selectedDateTime is
    // assigned; alternatively, showDatePicker returns a Future<> which has a
    // method then() (somewhat similar to JS promises) - see https://dart.dev/codelabs/async-await
    setState(() {
      _selectedDateTime = pickedDateTime;
    });
  }

  // remove the widget when done (not in view) from the modal page
  @override
  void dispose() {
    _numericalInputController.dispose();
    _textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _textInputController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Enter expense title'),
            ),
          ),
          Row(
            children: [
              // expand TextField and Row (for dateTimePicker) but also prevent
              // both from taking more than they need
              Expanded(
                child: TextField(
                  controller: _numericalInputController,
                  maxLength: 10,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    prefixText: '£ ',
                    label: Text('Enter amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  // horizontal alignment in this case
                  mainAxisAlignment: MainAxisAlignment.end,
                  // centre the row's widgets vertically (cosmetic, and optional)
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // the ! operator indicates the variable can never be null
                    Text(_selectedDateTime == null
                        ? 'No date picked'
                        : dateFormatter.format(_selectedDateTime!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedExpenseCategory,
                  items: ExpenseCategory.values
                      .map(
                        (expenseCategory) => DropdownMenuItem(
                          value: expenseCategory,
                          child: Text(expenseCategory.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      if (kDebugMode) {
                        print(value);
                      }

                      setState(() {
                        _selectedExpenseCategory = value;
                      });
                    }
                  }),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (kDebugMode) {
                    print('Expense title: ${_textInputController.text}');
                    print('Amount: ${_numericalInputController.text}');
                  }
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

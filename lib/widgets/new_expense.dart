import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense(this.addExpense, {super.key});

  final void Function(Expense expense) addExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // takes care of text input when the modal screen is required
  final _expenseTitleInputController = TextEditingController();
  final _expenseAmountInputController = TextEditingController();

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

  bool _validUserInput() {
    // returns null on failure
    final amountEntered = double.tryParse(_expenseAmountInputController.text);

    final validAmountEntered = amountEntered != null && amountEntered >= 0;

    if (_expenseTitleInputController.text.trim().isEmpty ||
        !validAmountEntered ||
        _selectedDateTime == null) {
      showDialog(
          context: context,
          builder: (dialogCtx) => AlertDialog(
                title: const Text('Invalid data entered'),
                content: const Text(
                    'Please check a valid title, amount and date were entered'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogCtx);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ));
      return false;
    }

    return true;
  }

  void _saveNewExpense() {
      final titleGiven = _expenseTitleInputController.text;
      final amountGiven = double.tryParse(_expenseAmountInputController.text);

      final newExpense = Expense(
          title: titleGiven,
          amount: amountGiven!,
          date: _selectedDateTime!,
          category: _selectedExpenseCategory);

      widget.addExpense(newExpense);
  }

  // remove the widget when done (not in view) from the modal page
  @override
  void dispose() {
    _expenseAmountInputController.dispose();
    _expenseTitleInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ensure that this as a modal page is pushed down more to avoid overlap
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _expenseTitleInputController,
            maxLength: 50,
            keyboardType: TextInputType.text,
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
                  controller: _expenseAmountInputController,
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
                      setState(() {
                        _selectedExpenseCategory = value;
                      });
                    }
                  }),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_validUserInput()){
                    _saveNewExpense();
                    Navigator.pop(context);
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

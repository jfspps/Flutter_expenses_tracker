import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          TextField(
            controller: _numericalInputController,
            maxLength: 10,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              prefixText: '£ ',
              label: Text('Enter amount'),
            ),
          ),
          Row(
            children: [
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
                onPressed: () {},
                child: const Text('Cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

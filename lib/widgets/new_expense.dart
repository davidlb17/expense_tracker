import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate;
  //dropdown doesnt accept controllers
  Category _category;

  //allows to delete the controller
  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );

    setState(() {
      _pickedDate = pickedDate;
    });
  }

  /*
  var _enteredTitle = '';

  void _saveTitle(String title) {
    _enteredTitle = title;
  }*/

  //form to add new expenses
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            //onChanged: _saveTitle,
            controller: _titleController,
            maxLength: 30,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    suffixText: '€',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_pickedDate == null
                        ? 'No date selected'
                        : formatter.format(_pickedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.date_range)),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_amountController.text);
                  print(_titleController.text);
                },
                child: const Text('Save data'),
              ),
              DropdownButton(
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                          child: Text(category.name.toUpperCase())),
                    )
                    .toList(),
                onChanged: (value) {
                  print(value);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/models/expense.dart';

// Define a StatefulWidget to handle dynamic changes.
class NewExpense extends StatefulWidget {
  // Constructor for the class with an optional key.
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  // Create the state for this widget.
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

// The state class for NewExpense, holding the logic and UI for this widget.
class _NewExpenseState extends State<NewExpense> {
  // Controller for the text field, managing the input text.
  final titleController =
      TextEditingController(); // Optimized for handling user input.
  final amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;
  void _showDialog() {
    if (Platform.isAndroid) { // adaptivity
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
         surfaceTintColor: Colors.grey,

          title: const Text(
            '!  Invalid input',
            style: TextStyle(fontSize: 25),
          ),
          // title of the error
          content: const Text(
            'Please make sure that the correct title,amount,date and category was entered',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
          //actual error message

          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          // backgroundColor: CupertinoColors.systemGrey4,
          // shadowColor: CupertinoColors.systemGrey,
          title: const Text(
            '!  Invalid input',
            style: TextStyle(fontSize: 25),
          ), // title of the error
          content: const Text(
            'Please make sure that the correct title,amount,date and category was entered',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
          //actual error message

          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    // to check the validity of entered inputs
    final enteredAmount = double.tryParse(
        amountController.text); // converts the text to double if possible
    // else returns null
    // trim is used to removing spaces before and after the text

    final amountIsValid = enteredAmount == null ||
        enteredAmount <= 0; // to check if a amount is valid
    if (titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      // to show error message
      _showDialog();
      return; // so that can be done after invalid inputs
    } else {
      widget.onAddExpense(
        Expense(
            title: titleController.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory),
      );
      Navigator.pop(context);
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  // Dispose method to clean up the controller when the widget is removed from the widget tree.
  void dispose() {
    // Used for optimizing memory by disposing of the controller.
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  // Build method to construct the UI.
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; // to determine the overlapping UI elements
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.white,
            Color.fromARGB(200, 192, 217, 248),
            Color.fromARGB(200, 181, 123, 204),
            Colors.blueAccent
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: SingleChildScrollView(
          child: Padding(
            // Padding around the column.
            padding: EdgeInsets.fromLTRB(
                16, 48, 16, keyboardSpace + 16), // padding from all the sides
            child: Column(
              // Column widget to layout children vertically.
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // to make sure all widgets are at the top
                    children: [
                      Expanded(
                        child: TextField(
                          enableSuggestions: true,

                          // TextField widget to accept user input.
                          controller: titleController,
                          // Connects the text field to the controller.
                          maxLength: 50,
                          // Limits user input to 50 characters.
                          keyboardType: TextInputType.text,
                          // Sets the keyboard type for text input.
                          decoration: const InputDecoration(
                            // Decoration for the TextField.
                            label: Text(
                              'Title',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ), // Label for the TextField.
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          // it is wrapped under Expanded because it doesn't have constraints
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\₹ ',
                            // to add a dollar sign in text field.
                            label: Text(
                              'Amount',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    enableSuggestions: true,

                    // TextField widget to accept user input.
                    controller: titleController,
                    // Connects the text field to the controller.
                    maxLength: 50,
                    // Limits user input to 50 characters.
                    keyboardType: TextInputType.text,
                    // Sets the keyboard type for text input.
                    decoration: const InputDecoration(
                      // Decoration for the TextField.
                      label: Text(
                        'Title',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ), // Label for the TextField.
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 17),
                                  // to change the color of the text of category
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ), // to
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // to keep selected date at the end
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            // adding ! mark to force dart to assume _selectedDate won't be null
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          // it is wrapped under Expanded because it doesn't have constraints
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\₹ ',
                            // to add a dollar sign in text field.
                            label: Text(
                              'Amount',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // to keep selected date at the end
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            // adding ! mark to force dart to assume _selectedDate won't be null
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    children: [
                      const SizedBox(
                        width: 340,
                      ),
                      ElevatedButton(
                        // ElevatedButton widget to create a styled button.
                        onPressed: () {
                          _submitExpenseData();
                        },
                        child: const Text(
                          'Save Expense',
                          style: TextStyle(fontSize: 16),
                        ), // Text displayed on the button.
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    // Row widget to layout children horizontally.
                    children: [
                      // onChanged expects a dynamic value
                      // map is used to change the value type
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    // to change the color of the text of category
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }), // to select the category
                      const Spacer(),
                      ElevatedButton(
                        // ElevatedButton widget to create a styled button.
                        onPressed: () {
                          _submitExpenseData();
                        },
                        child: const Text(
                          'Save Expense',
                          style: TextStyle(fontSize: 16),
                        ), // Text displayed on the button.
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}

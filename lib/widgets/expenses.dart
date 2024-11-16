import 'package:finance_app/main.dart';
import 'package:finance_app/widgets/chart/chart.dart';
import 'package:finance_app/widgets/expenses_list/expense_list.dart';
import 'package:finance_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    // Create the mutable state for this widget
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // List of registered expenses

  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 500,
        date: DateTime.now(), // sets the current date and time
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 200,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Travel',
        amount: 200,
        date: DateTime.now(),
        category: Category.travel),
  ];
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); // to remove previous snack bars
    ScaffoldMessenger.of(context).showSnackBar(
      // used to show message that a item from list was removed
      SnackBar(
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // _addExpense(expense); // it will not be at the same place from where it was removed
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
        content: const Center(
          child: Text('Expense deleted'),
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    //context -> widget meta information
    // information on relation to other widgets
    // builder always wants a function as a value

    showModalBottomSheet(
      useSafeArea: true,// so that it doesn not overlaps with top camera
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
          onAddExpense:
              _addExpense), // Display NewExpense widget inside the modal
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text(
        'No expenses are there. Start adding some',
        style: TextStyle(fontSize: 20, color: Colors.black87),
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onRemoveExpense:
            _removeExpense, // Pass the list of expenses to the ExpenseList widget
      );
    }
    return Scaffold(
        appBar: AppBar(
          // actions is used to add buttons in the AppBar
          actions: [
            IconButton(
                onPressed:
                    _openAddExpenseOverlay, // Calls the method to open the modal bottom sheet
                icon: const Icon(Icons.add)), // Icon for the button
          ],
          title: const Text(
            'Expense Tracker',
            style: TextStyle(
              color: Colors.white, // Color of the AppBar title text
            ),
          ),
          backgroundColor: Colors.deepPurpleAccent.withOpacity(0.75),
        ),
        body: width < 600
            ? Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Colors.black87,
                        Colors.black,
                        Colors.black,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                  ),
                  Chart(expenses: _registeredExpenses),
                  Expanded(
                    child: mainContent,
                  )
                ],
              )
            : Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Colors.black87,
                        Colors.black,
                        Colors.black,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                  ),
                  Expanded(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                  Expanded(
                    child: mainContent,
                  )
                ],
              ));
  }
}

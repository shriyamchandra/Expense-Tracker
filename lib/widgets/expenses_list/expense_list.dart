import 'package:finance_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    // itemCount is for no of widgets to build
    return ListView.builder(
      // this make sure that all the items are created when they needed
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(

        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Colors.red, Colors.deepOrange, Colors.yellow],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: const Center(
              child: Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          )),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
    // Dismissible is used to remove widgets
  }
}

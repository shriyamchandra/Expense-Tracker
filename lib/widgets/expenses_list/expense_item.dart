import 'package:finance_app/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class ExpenseItem extends StatelessWidget {
  // named parameters in curly braces
  // positional parameters are always required
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black87,
      semanticContainer: true,
      borderOnForeground: true,

      child: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          gradient: const LinearGradient(


            colors: [
              Colors.deepPurple,
              // Colors.black87,
              Colors.deepPurpleAccent,
              Colors.purple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Text(expense.title,style: const TextStyle(color: Colors.white,fontSize: 18),),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text('₹${expense.amount.toStringAsFixed(2)}',style: TextStyle(color: Colors.white),),
                  const Spacer(), // to provide spacing between widgets
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category],color: Colors.white,),
                      const SizedBox(width: 10), // to provide space between icon and date
                      Text(expense.formattedDate,style: const TextStyle(color: Colors.white),),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.filteredExpenses,
  });

  final List<Expense> filteredExpenses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => ListView.builder(
            itemCount: filteredExpenses.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredExpenses[index].expenseName),
                // Display more fields as needed
              );
            },
          )),
    );
  }
}

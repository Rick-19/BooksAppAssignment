import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/expense.dart';
import '../controller/expense_controller.dart';
import '../widget/expense_list.dart';

class ExpenseListScreen extends StatefulWidget {
  ExpenseListScreen({Key? key}) : super(key: key);

  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final ExpenseController expenseController =
      Get.find(); // Get your ExpenseController

  final TextEditingController _searchController = TextEditingController();
  List<Expense> filteredExpenses = [];

  @override
  void initState() {
    super.initState();
    // Initially, display all expenses from the controller
    filteredExpenses = expenseController.expenses;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredExpenses = expenseController.expenses.where((expense) {
        return expense.expenseName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Expense',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          ExpenseList(filteredExpenses: filteredExpenses),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/expense_service.dart';
import '../models/expense.dart';
import './expense_list_screen.dart';
import 'package:get/get.dart';
import '../controller/expense_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  List<Expense> expenses = [];
  bool isLoading = false;

  void fetchExpenses() async {
    setState(() {
      isLoading = true; // Set loading flag to true while waiting for response
    });
    try {
      final fetchedExpenses = await ExpenseService.fetchExpenses(
          _textEditingController.text, context);
      setState(() {
        expenses = fetchedExpenses;
        isLoading = false;
      });
      final expenseController = Get.find<ExpenseController>();
      expenseController.addExpenses(fetchedExpenses);
      if (expenses.isNotEmpty) {
        // Navigate to the new screen (ExpenseListScreen)
        Get.off(
          () => ExpenseListScreen(),
        );
      }
    } catch (error) {
      // print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              width: 200,
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 72, 70, 70), width: 2),
                  ),
                  hintText: 'Email',
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () => fetchExpenses(),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

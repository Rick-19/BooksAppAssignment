import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'package:dio/dio.dart';

class ExpenseService {
  static Future<List<Expense>> fetchExpenses(
      String email, BuildContext context) async {
    const url = 'https://staging.thenotary.app/doLogin';
    final requestData = {"email": email};

    try {
      final dio = Dio();
      final response = await dio.post(url, data: requestData);

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        return parseExpensesFromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch expenses');
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while fetching expenses.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      throw Exception('Failed to fetch expenses');
    }
  }

  static List<Expense> parseExpensesFromJson(
      Map<String, dynamic> jsonResponse) {
    final List<dynamic> expenseList = jsonResponse['expenseList'];
    final List<Expense> expenses = [];

    for (final expenseData in expenseList) {
      final expense = Expense.fromJson(expenseData);
      expenses.add(expense);
    }
    return expenses;
  }
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import '../models/expense.dart';

class ExpenseController extends GetxController {
  RxList<Expense> expenses = <Expense>[].obs;
  final _box = GetStorage(); // Create a GetStorage instance

  @override
  void onInit() {
    // Load expenses from storage when the controller is initialized
    loadExpensesFromStorage();
    super.onInit();
  }

  void addExpenses(List<Expense> newExpenses) {
    expenses.assignAll(newExpenses);
    // Save the updated expenses to storage
    saveExpensesToStorage();
  }

  void loadExpensesFromStorage() {
    final jsonData = _box.read<List>('expenses') ?? <Map<String, dynamic>>[];
    expenses.assignAll(jsonData.map((data) => Expense.fromJson(data)));
  }

  void saveExpensesToStorage() {
    final jsonData = expenses.map((expense) => expense.toJson()).toList();
    _box.write('expenses', jsonData);
  }
}

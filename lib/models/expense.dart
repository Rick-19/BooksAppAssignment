class Expense {
  final String expenseName;
  final String description;
  final double cost;

  Expense({
    required this.expenseName,
    required this.description,
    required this.cost,
  });

  // Factory method to create an Expense object from a JSON map
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      expenseName: json['expenseName'] as String,
      description: json['description'] as String,
      cost: (json['cost'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expenseName': expenseName,
      'description': description,
      'cost': cost,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      expenseName: map['expenseName'],
      description: map['description'],
      cost: map['cost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expenseName': expenseName,
      'description': description,
      'cost': cost,
    };
  }
}

class BudgetModel {
  final String id;
  final String name;
  final double amount;
  final String type;
  final String category;
  final String period;
  final double savedAmount;

  BudgetModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    required this.category,
    required this.period,
    this.savedAmount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'type': type,
      'category': category,
      'period': period,
      'savedAmount': savedAmount,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      type: map['type'],
      category: map['category'],
      period: map['period'],
      savedAmount: map['savedAmount'] ?? 0,
    );
  }
}
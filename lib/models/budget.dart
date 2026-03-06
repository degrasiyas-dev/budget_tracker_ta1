class Budget {
  String name;
  double totalAmount;
  double savedAmount;

  Budget({
    required this.name,
    required this.totalAmount,
    this.savedAmount = 0,
  });
}
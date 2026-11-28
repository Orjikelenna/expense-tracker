class Expense {
  final String id;
  final String title;
  final double amount;
  final String category;
  final String type; // 'Expense' or 'Income'
  final DateTime date;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    this.type = 'Expense',
    required this.date,
  });
}
import 'package:flutter/material.dart';
import '../models/expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _titleController = TextEditingController();
final _amountController = TextEditingController();

final List<String> _categories = ['Food', 'Transport', 'Bills', 'Others'];

  final List<Expense> _expenses = [
    Expense(
      id: '1',
      title: 'Lunch',
      amount: 1500,
      category: 'Food',
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      title: 'Bus fare',
      amount: 700,
      category: 'Transport',
      date: DateTime.now(),
    ),
  ];

   double get _totalIncome => _expenses
      .where((e) => e.type == 'Income')
      .fold(0, (sum, e) => sum + e.amount);

  double get _totalExpenses => _expenses
      .where((e) => e.type == 'Expense')
      .fold(0, (sum, e) => sum + e.amount);

  double get _balance => _totalIncome - _totalExpenses;

  void _showAddDialog() {
    String selectedCategory = 'Food';
    String selectedType = 'Expense';
    showDialog(
      context: context,
      builder:(context) => StatefulBuilder(
      builder:(context, setDialogState) => AlertDialog(
        title: const Text('Add Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            TextField(
              controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
             
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration( labelText: 'Amount (₦)'),
            ),
           const SizedBox(height: 12),
DropdownButtonFormField<String>(
  initialValue: selectedCategory,
  decoration: const InputDecoration(
    labelText: 'Category'
  ),

  items: _categories.map((cat ) {
    return DropdownMenuItem(
      value: cat,
       child: Text(cat));
  }).toList(),
  onChanged: (value) {
    if (value != null){
      setDialogState((){
        selectedCategory = value;
      });
    }
  },
     // setDialogState(() => selectedCategory = val!)
             ),

             const SizedBox(height: 12),
             DropdownButtonFormField(
             initialValue: selectedType,
             decoration: const InputDecoration(
              labelText: 'Transaction Type',
             ),
             items: ['Expense', 'Income'].map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
             }).toList(),
             onChanged: (value) {
              if (value != null) {
                setDialogState((){
                  selectedType = value;
                });
               }
              },
             ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),

          ),
          ElevatedButton(onPressed: () {
              final title = _titleController.text;
              final amount = double.tryParse(_amountController.text);
              if (title.isNotEmpty && amount != null) {
                setState(() {
                  _expenses.add(Expense(
                    id: DateTime.now().toString(),
                    title: title,
                    amount: amount,
                    category: selectedCategory,
                    type: selectedType,
                    date: DateTime.now(),
                  ));
                });
                _titleController.clear();
                _amountController.clear();
                Navigator.pop(context);
             }
           },
           child: const Text('Add'),
           
          ),
        ],
      ),
     ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            //color:Colors.green,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Column(
              children: [
                const Text('Balance'),
                Text(
                  '₦${_balance.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    title: Text(expense.title),
                    subtitle: Text(expense.category),
                    trailing: Text(
                      '₦${expense.amount.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    
      floatingActionButton: FloatingActionButton( 
      onPressed: _showAddDialog,
      child: const Icon(Icons.add),
      ),
    );
  }
}
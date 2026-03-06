import 'package:flutter/material.dart';
import '../models/budget.dart';

class EditBudgetScreen extends StatefulWidget {
  final Budget budget;
  final Function(Budget) onSave;

  EditBudgetScreen({required this.budget, required this.onSave});

  @override
  _EditBudgetScreenState createState() => _EditBudgetScreenState();
}

class _EditBudgetScreenState extends State<EditBudgetScreen> {
  late TextEditingController _savedAmountController;

  @override
  void initState() {
    super.initState();
    _savedAmountController = TextEditingController(
      text: widget.budget.savedAmount.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Budget')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Budget: ${widget.budget.name}'),
            TextField(
              controller: _savedAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount Saved'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double saved = double.tryParse(_savedAmountController.text) ?? 0;
                widget.onSave(
                  Budget(
                    name: widget.budget.name,
                    totalAmount: widget.budget.totalAmount,
                    savedAmount: saved,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
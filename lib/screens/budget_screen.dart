import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';
import '../widgets/budget_card.dart';
import 'add_budget_screen.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  void _editSavedAmount(BuildContext context, int index) async {
    final provider = Provider.of<BudgetProvider>(context, listen: false);
    final budget = provider.budgets[index];
    TextEditingController controller = TextEditingController(text: budget.savedAmount.toString());

    double? newAmount = await showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Amount Saved'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Amount Saved'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double value = double.tryParse(controller.text) ?? budget.savedAmount;
                Navigator.pop(context, value);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (newAmount != null) {
      setState(() {
        provider.updateSavedAmount(index, newAmount);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BudgetProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Budgets",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddBudgetScreen(),
                  ),
                );
              },
              child: const Text("Create New Budget"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: provider.budgets.isEmpty
                  ? const Center(
                      child: Text("No budgets yet"),
                    )
                  : ListView.builder(
                      itemCount: provider.budgets.length,
                      itemBuilder: (context, index) {
                        return BudgetCard(
                          budget: provider.budgets[index],
                          onEdit: () => _editSavedAmount(context, index),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
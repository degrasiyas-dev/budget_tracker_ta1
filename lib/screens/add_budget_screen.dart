import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';
import '../models/budget_model.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {

  final nameController = TextEditingController();
  final amountController = TextEditingController();

  String type = "expense";
  String category = "All Expense";
  String period = "This Month";

  void saveBudget() {

    final budget = BudgetModel(
      id: DateTime.now().toString(),
      name: nameController.text,
      amount: double.parse(amountController.text),
      type: type,
      category: category,
      period: period,
    );

    context.read<BudgetProvider>().addBudget(budget);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Create Budget")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Budget Name",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(
              value: type,
              items: const [
                DropdownMenuItem(
                  value: "expense",
                  child: Text("Expense"),
                ),
                DropdownMenuItem(
                  value: "income",
                  child: Text("Income"),
                ),
              ],
              onChanged: (v) {
                setState(() {
                  type = v!;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(
              value: period,
              items: const [
                DropdownMenuItem(
                  value: "This Week",
                  child: Text("This Week"),
                ),
                DropdownMenuItem(
                  value: "This Month",
                  child: Text("This Month"),
                ),
                DropdownMenuItem(
                  value: "This Year",
                  child: Text("This Year"),
                ),
              ],
              onChanged: (v) {
                setState(() {
                  period = v!;
                });
              },
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: saveBudget,
              child: const Text("Save Budget"),
            )
          ],
        ),
      ),
    );
  }
}
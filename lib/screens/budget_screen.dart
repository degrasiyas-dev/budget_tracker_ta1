import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';
import '../widgets/budget_card.dart';
import 'add_budget_screen.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

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
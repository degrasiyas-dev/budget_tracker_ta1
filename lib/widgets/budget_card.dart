import 'package:flutter/material.dart';
import '../models/budget_model.dart';

class BudgetCard extends StatelessWidget {

  final BudgetModel budget;

  const BudgetCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {

    double spent = 0;

    double progress = spent / budget.amount;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  budget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: "delete",
                      child: Text("Delete"),
                    )
                  ],
                )
              ],
            ),

            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: progress,
            ),

            const SizedBox(height: 10),

            Text(
              "₱$spent / ₱${budget.amount}",
            )
          ],
        ),
      ),
    );
  }
}
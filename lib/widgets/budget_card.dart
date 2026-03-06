import 'package:flutter/material.dart';
import '../models/budget_model.dart';

class BudgetCard extends StatelessWidget {
  final BudgetModel budget;
  final VoidCallback? onEdit;

  const BudgetCard({super.key, required this.budget, this.onEdit});

  @override
  Widget build(BuildContext context) {
    double progress = budget.savedAmount / budget.amount;

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
                      value: "edit",
                      child: Text("Edit Amount Saved"),
                    ),
                    const PopupMenuItem(
                      value: "delete",
                      child: Text("Delete"),
                    )
                  ],
                  onSelected: (value) {
                    if (value == "edit" && onEdit != null) {
                      onEdit!();
                    }
                    // Handle delete if needed
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress.clamp(0, 1),
            ),
            const SizedBox(height: 10),
            Text(
              "₱${budget.savedAmount} / ₱${budget.amount}",
            )
          ],
        ),
      ),
    );
  }
}
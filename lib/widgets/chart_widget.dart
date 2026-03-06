import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transaction_model.dart';

class ChartWidget extends StatelessWidget {

  final List<TransactionModel> transactions;

  const ChartWidget({super.key, required this.transactions});

  Map<String, double> calculateData() {

    Map<String, double> data = {};

    for (var t in transactions) {
      data[t.category] = (data[t.category] ?? 0) + t.amount;
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {

    final data = calculateData();

    final total = data.values.fold(0.0, (a, b) => a + b);

    // Assign colors to categories
    final Map<String, Color> categoryColors = {
      'Food': Colors.red,
      'Transportation': Colors.blue,
      // Add more categories and colors as needed
    };

    final sections = data.entries.map((e) {
      final color = categoryColors[e.key] ?? Colors.teal;
      return PieChartSectionData(
        value: e.value,
        color: color,
        title: '',
        radius: 70,
      );
    }).toList();

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 50,
                ),
              ),
              Text(
                "₱${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Legend
        Wrap(
          spacing: 16,
          children: data.keys.map((category) {
            final color = categoryColors[category] ?? Colors.teal;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: color, size: 16),
                const SizedBox(width: 4),
                Text(category),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
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

    final sections = data.entries.map((e) {

      return PieChartSectionData(
        value: e.value,
        title: "",
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
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/chart_widget.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  String type = "expense";

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TransactionProvider>(context);

    final transactions = provider.transactions
        .where((t) => t.type == type)
        .toList();

    return Scaffold(

      body: SafeArea(
        child: Column(

          children: [

            const SizedBox(height: 10),

            const Text(
              "My Wallet",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [

                tab("Expense", "expense"),

                tab("Income", "income"),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: transactions.isEmpty
                  ? const Center(child: Text("No data yet"))
                  : Column(
                      children: [

                        ChartWidget(transactions: transactions),

                        const SizedBox(height: 20),

                        const Text(
                          "Ranking",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Expanded(
                          child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {

                              final t = transactions[index];

                              return ListTile(
                                title: Text(t.category),
                                trailing: Text(
                                  "₱${t.amount}",
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget tab(String label, String value) {

    bool selected = type == value;

    return Expanded(
      child: GestureDetector(

        onTap: () {
          setState(() {
            type = value;
          });
        },

        child: Container(
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 3,
                color: selected ? Colors.black : Colors.transparent,
              ),
            ),
          ),

          child: Center(
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
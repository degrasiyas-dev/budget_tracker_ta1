import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 10),

            const Text(
              "My Wallet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Total Balance",
              style: TextStyle(color: Colors.grey[600]),
            ),

            const SizedBox(height: 5),

            Text(
              "₱ ${provider.balance.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                card("Expense", provider.totalExpense),

                card("Income", provider.totalIncome),
              ],
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transactions",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text("Daily"),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: provider.transactions.isEmpty
                  ? const Center(
                      child: Text("No recent transactions."),
                    )
                  : ListView.builder(
                      itemCount: provider.transactions.length,
                      itemBuilder: (context, index) {
                        return TransactionTile(
                          transaction: provider.transactions[index],
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget card(String title, double amount) {

    return Container(
      width: 140,
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5)
        ],
      ),

      child: Column(
        children: [

          Text(title),

          const SizedBox(height: 5),

          Text("₱ ${amount.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
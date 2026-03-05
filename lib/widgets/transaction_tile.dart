import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {

  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {

    return ListTile(

      title: Text(transaction.category),

      subtitle: Text(
        DateFormat('dd/MM/yyyy').format(transaction.date),
      ),

      trailing: Text(
        "₱${transaction.amount}",
        style: TextStyle(
          color: transaction.type == "expense"
              ? Colors.red
              : Colors.green,
        ),
      ),
    );
  }
}
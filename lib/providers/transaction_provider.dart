import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {

  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  TransactionProvider() {
    loadTransactions();
  }

  double get totalIncome {
    return _transactions
        .where((t) => t.type == "income")
        .fold(0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return _transactions
        .where((t) => t.type == "expense")
        .fold(0, (sum, item) => sum + item.amount);
  }

  double get balance => totalIncome - totalExpense;

  Future<void> addTransaction(TransactionModel transaction) async {

    _transactions.add(transaction);

    await saveTransactions();

    notifyListeners();
  }

  Future<void> saveTransactions() async {

    final prefs = await SharedPreferences.getInstance();

    List<String> data = _transactions
        .map((t) => jsonEncode(t.toMap()))
        .toList();

    prefs.setStringList("transactions", data);
  }

  Future<void> loadTransactions() async {

    final prefs = await SharedPreferences.getInstance();

    List<String>? data = prefs.getStringList("transactions");

    if (data != null) {
      _transactions = data
          .map((e) => TransactionModel.fromMap(jsonDecode(e)))
          .toList();
    }

    notifyListeners();
  }
}
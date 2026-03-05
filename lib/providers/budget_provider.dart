import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/budget_model.dart';

class BudgetProvider with ChangeNotifier {

  List<BudgetModel> _budgets = [];

  List<BudgetModel> get budgets => _budgets;

  BudgetProvider() {
    loadBudgets();
  }

  Future<void> addBudget(BudgetModel budget) async {

    _budgets.add(budget);

    await saveBudgets();

    notifyListeners();
  }

  Future<void> deleteBudget(String id) async {

    _budgets.removeWhere((b) => b.id == id);

    await saveBudgets();

    notifyListeners();
  }

  Future<void> saveBudgets() async {

    final prefs = await SharedPreferences.getInstance();

    List<String> data =
        _budgets.map((b) => jsonEncode(b.toMap())).toList();

    prefs.setStringList("budgets", data);
  }

  Future<void> loadBudgets() async {

    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList("budgets");

    if (data != null) {
      _budgets =
          data.map((e) => BudgetModel.fromMap(jsonDecode(e))).toList();
    }

    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction_model.dart';
import '../utils/categories.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {

  String type = "expense";

  String selectedCategory = "";

  DateTime selectedDate = DateTime.now();

  final amountController = TextEditingController();

  void pickDate() async {

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void saveTransaction() {

    if (amountController.text.isEmpty || selectedCategory.isEmpty) return;

    final transaction = TransactionModel(
      id: DateTime.now().toString(),
      amount: double.parse(amountController.text),
      category: selectedCategory,
      date: selectedDate,
      type: type,
    );

    context.read<TransactionProvider>().addTransaction(transaction);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final categories =
        type == "expense" ? Categories.expense : Categories.income;

    return Scaffold(

      appBar: AppBar(
        title: const Text("New Transaction"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(
              children: [

                tab("Expense", "expense"),

                tab("Income", "income"),
              ],
            ),

            const SizedBox(height: 20),

            const Text("Amount"),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: "₱ ",
              ),
            ),

            const SizedBox(height: 20),

            const Text("Category"),

            const SizedBox(height: 10),

            Wrap(
                spacing: 6,  
                runSpacing: 6,  
                children: categories.map((cat) {
                  bool selected = selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(
                      cat,
                      style: TextStyle(fontSize: 12),  
                    ),
                    selected: selected,
                    visualDensity: VisualDensity.compact,  
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,  
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = cat;
                      });
                    },
                  );
                }).toList(),
              ),

            const SizedBox(height: 20),

            const Text("Date"),

            const SizedBox(height: 5),

            ElevatedButton(
              onPressed: pickDate,
              child: Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveTransaction,
                child: Text(
                  type == "expense"
                      ? "Save Expense"
                      : "Save Income",
                ),
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
            selectedCategory = "";
          });
        },

        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 3,
                color: selected ? Colors.black : Colors.transparent,
              ),
            ),
          ),
          child: Center(child: Text(label)),
        ),
      ),
    );
  }
}
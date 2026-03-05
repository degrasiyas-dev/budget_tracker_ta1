import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'report_screen.dart';
import 'add_transaction_screen.dart';
import 'budget_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int currentIndex = 0;

  final pages = [
    const HomeScreen(),
    const ReportScreen(),
    const SizedBox(),
    const BudgetScreen(),
    const ProfileScreen(),
  ];

  void onTap(int index) {

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AddTransactionScreen(),
        ),
      );
      return;
    }

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
            )
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            navItem(Icons.home_outlined, "Home", 0),

            navItem(Icons.pie_chart_outline, "Report", 1),

            floatingAddButton(),

            navItem(Icons.account_balance_wallet_outlined, "Budget", 3),

            navItem(Icons.person_outline, "Account", 4),
          ],
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String label, int index) {

    bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            color: selected ? Colors.black : Colors.grey,
          ),

          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.black : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget floatingAddButton() {

    return GestureDetector(
      onTap: () => onTap(2),

      child: Container(
        height: 55,
        width: 55,
        decoration: const BoxDecoration(
          color: Color(0xFFD7E8E5),
          shape: BoxShape.circle,
        ),

        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
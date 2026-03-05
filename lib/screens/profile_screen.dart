import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);
    final theme = Provider.of<ThemeProvider>(context);

    final user = auth.user;

    bool isDark = theme.themeMode == ThemeMode.dark;

    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const Text(
                "Profile",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              CircleAvatar(
                radius: 40,
                child: Text(
                  user?.name.substring(0,1) ?? "U",
                  style: const TextStyle(fontSize: 30),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                user?.name ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                user?.email ?? "",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Edit Profile"),
                onTap: () {},
              ),

              const Divider(),

              SwitchListTile(
                title: const Text("Dark Mode"),
                value: isDark,
                onChanged: (value) {
                  theme.toggleTheme(value);
                },
              ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),

                onTap: () {
                  auth.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
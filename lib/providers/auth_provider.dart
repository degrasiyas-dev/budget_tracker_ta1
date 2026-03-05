import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {

  UserModel? _user;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  UserModel? get user => _user;

  Future<void> signup(String name, String email, String password) async {

    final prefs = await SharedPreferences.getInstance();

    UserModel newUser = UserModel(
      name: name,
      email: email,
      password: password,
    );

    prefs.setString("user", jsonEncode(newUser.toMap()));
  }

  Future<bool> login(String email, String password) async {

    final prefs = await SharedPreferences.getInstance();

    String? userData = prefs.getString("user");

    if (userData == null) return false;

    Map<String, dynamic> map = jsonDecode(userData);

    UserModel savedUser = UserModel.fromMap(map);

    if (savedUser.email == email && savedUser.password == password) {
      _user = savedUser;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> updateUserName(String newName) async {
    if (_user == null) return;

    _user = UserModel(
      name: newName,
      email: _user!.email,
      password: _user!.password,
    );

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(_user!.toMap()));
    notifyListeners();
  }
}
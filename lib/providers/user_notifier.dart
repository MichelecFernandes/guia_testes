import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../shared/app_constants.dart';
import '../controllers/auth_controller.dart';

class UserNotifier extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  Future<void> loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    final token = prefs.getString('accessToken');

    if (userId == null || token == null) {
      _user = null;
      notifyListeners();
      return;
    }

    try {
      http.Response response = await http.get(
        Uri.parse('${AppConstants.baseAuthApiUrl}users/$userId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _user = User.fromJson(json.decode(response.body));
      } else {
        await AuthController.instance.logout();
        _user = null;
      }
    } catch (e) {
      _user = null;
    }
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
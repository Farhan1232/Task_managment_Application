



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _loading = false;
  bool get loading => _loading;

  AuthProvider() {
    _loadLoggedInStatus();
  }

  void _loadLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  void _setLoggedInStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
    _isLoggedIn = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> login(String email, String password, BuildContext context) async {
    setLoading(true);
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data['token']);
        print('Login successfully');

        _setLoggedInStatus(true);
        setLoading(false);

        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Login successful'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        setLoading(false);
        print('Failed');
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }

  Future<void> logout() async {
    _setLoggedInStatus(false);
  }
}

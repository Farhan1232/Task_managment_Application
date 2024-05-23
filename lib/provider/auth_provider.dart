

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false; // Define the isLoggedIn property
  bool get isLoggedIn => _isLoggedIn; // Define the getter

  bool _loading = false;
  bool get loading => _loading;

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
        setLoading(false);
        _isLoggedIn = true; // Set isLoggedIn to true after successful login
        var data = jsonDecode(response.body);
        print(data['token']);
        print('Login successfully');
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
}

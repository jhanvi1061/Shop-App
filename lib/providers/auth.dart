import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    const API_KEY = 'AIzaSyAMrm-ScbobTLEmPWoEI1CPlQ4hrMUq-9o';
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$API_KEY');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
  }
}

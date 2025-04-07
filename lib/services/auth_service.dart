import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../models/user.dart';
import 'database_service.dart';

class AuthService {
  final ApiService _databaseService;

  AuthService(this._databaseService);

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') != null;
  }

Future<Map<String, dynamic>> signInWithEmailAndPassword(
    String email, String password) async {
  try {
    Response result = await _databaseService.post(
      endpoint: "auth/login",
      body: {
        "name": email,
        "password": password,
      },
    );

    // Check for successful response
    if (result.statusCode == 200 || result.statusCode == 201) {
      final data = jsonDecode(result.body);
      return {
        'success': true,
        'data': data,
      };
    } else {
      // Handle wrong credentials or failure
      final errorData = jsonDecode(result.body);
      return {
        'success': false,
        'message': errorData['message'] ?? 'Invalid email or password',
      };
    }
  } catch (e) {
    return {
      'success': false,
      'message': 'An unexpected error occurred: $e',
    };
  }
}

  // Sign out
  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }


  // Get current user ID
  Future<String?> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Get current driver ID
  Future<String?> getCurrentDriverId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('driverId');
  }
}
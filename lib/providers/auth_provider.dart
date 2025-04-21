import 'package:flutter/material.dart';
import 'package:school_van_tracker/models/user.dart';
import 'package:school_van_tracker/services/auth_service.dart';
import 'package:school_van_tracker/services/database_service.dart';
import 'package:school_van_tracker/services/storage_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  final ApiService _databaseService = ApiService();
  late final AuthService _authService;

  AuthProvider() {
    _authService = AuthService(_databaseService);
  }
  final StorageService _storageService = StorageService();

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await _storageService.getAuthToken();
      if (token != null) {
        const userData = '';
        _user = User.fromJson(userData as Map<String, dynamic>);
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
        _user = null;
      }
    } catch (e) {
      _isAuthenticated = false;
      _user = null;
      await _storageService.deleteAuthToken();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result =
          await _authService.signInWithEmailAndPassword(email, password);

      if (result['success'] == true) {
        final userData = result['data'];

        _user = User.fromJson({
          'id': userData['id'] ?? '123456',
          'name': userData['name'] ?? 'Kate Winslet',
          'email': email,
          'phone': userData['phone'] ?? '0771278951',
          'image_url':
              userData['image_url'] ?? 'https://i.pravatar.cc/150?img=5',
          'children_ids': userData['children_ids'] ?? ['child1', 'child2'],
          'is_verified': userData['is_verified'] ?? true,
        });

        _isAuthenticated = true;

        await _storageService.saveAuthToken(userData['token'] ?? 'mock_token');
      } else {
        throw Exception(result['message'] ?? 'Login failed. Please try again.');
      }
    } catch (e) {
      // You can either rethrow or handle directly here
      throw Exception(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(
      String name, String email, String phone, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would make an API call
      // For demo purposes, we'll simulate a successful signup
      await Future.delayed(const Duration(seconds: 2));

      // We don't set the user or authenticated state here
      // as typically users need to verify email or login after signup
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signOut();
      await _storageService.deleteAuthToken();
      _user = null;
      _isAuthenticated = false;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(String name, String phone) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_user == null) throw Exception('User not authenticated');

      // In a real app, this would make an API call
      await Future.delayed(const Duration(seconds: 1));

      _user = _user!.copyWith(
        name: name,
        phone: phone,
      );
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfileImage(String imageUrl) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_user == null) throw Exception('User not authenticated');

      // In a real app, this would make an API call
      await Future.delayed(const Duration(seconds: 1));

      _user = _user!.copyWith(
        imageUrl: imageUrl,
      );
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

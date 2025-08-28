import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../utils/app_constants.dart';

enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthService extends ChangeNotifier {
  // Private properties
  User? _currentUser;
  AuthState _authState = AuthState.initial;
  String? _errorMessage;
  bool _isLoading = false;

  // Getters
  User? get currentUser => _currentUser;
  AuthState get authState => _authState;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _authState == AuthState.authenticated && _currentUser != null;
  bool get isUnauthenticated => _authState == AuthState.unauthenticated;

  // Constructor
  AuthService() {
    _initializeAuth();
  }

  // Initialize authentication state
  Future<void> _initializeAuth() async {
    _setAuthState(AuthState.loading);

    try {
      await _loadUserFromStorage();

      if (_currentUser != null) {
        _setAuthState(AuthState.authenticated);
      } else {
        _setAuthState(AuthState.unauthenticated);
      }
    } catch (e) {
      _setError('Failed to initialize authentication: ${e.toString()}');
      _setAuthState(AuthState.unauthenticated);
    }
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

      if (isLoggedIn) {
        final userId = prefs.getString('user_id');
        final email = prefs.getString('user_email');
        final username = prefs.getString('user_username');

        if (userId != null && email != null && username != null) {
          _currentUser = User(
            id: userId,
            email: email,
            username: username,
            createdAt: DateTime.now(),
          );
        }
      }
    } catch (e) {
      debugPrint('Error loading user from storage: $e');
    }
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserToStorage() async {
    if (_currentUser == null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('user_id', _currentUser!.id);
      await prefs.setString('user_email', _currentUser!.email);
      await prefs.setString('user_username', _currentUser!.username);
    } catch (e) {
      debugPrint('Error saving user to storage: $e');
    }
  }

  // Clear user data from SharedPreferences
  Future<void> _clearUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      debugPrint('Error clearing user from storage: $e');
    }
  }

  // Login method
  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _setError('Email and password are required');
      return false;
    }

    if (!isValidEmail(email)) {
      _setError('Please enter a valid email address');
      return false;
    }

    if (password.length < 6) {
      _setError('Password must be at least 6 characters');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Create user from login data
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        username: email.split('@')[0],
        createdAt: DateTime.now(),
      );

      await _saveUserToStorage();
      _setAuthState(AuthState.authenticated);
      _setLoading(false);

      return true;
    } catch (e) {
      _setError('Login failed: ${e.toString()}');
      _setAuthState(AuthState.error);
      _setLoading(false);
      return false;
    }
  }

  // Register method - CORRECTED SIGNATURE
  Future<bool> register(String email, String username, String password) async {
    // Validation
    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      _setError('All fields are required');
      return false;
    }

    if (!isValidEmail(email)) {
      _setError('Please enter a valid email address');
      return false;
    }

    if (username.length < 3 || username.length > 20) {
      _setError('Username must be between 3 and 20 characters');
      return false;
    }

    if (password.length < 6) {
      _setError('Password must be at least 6 characters');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        username: username,
        createdAt: DateTime.now(),
      );

      await _saveUserToStorage();
      _setAuthState(AuthState.authenticated);
      _setLoading(false);

      return true;
    } catch (e) {
      _setError('Registration failed: ${e.toString()}');
      _setAuthState(AuthState.error);
      _setLoading(false);
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    _setLoading(true);

    try {
      await _clearUserFromStorage();
      _currentUser = null;
      _setAuthState(AuthState.unauthenticated);
      _clearError();
    } catch (e) {
      debugPrint('Error during logout: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update user profile - CORRECTED SIGNATURE
  Future<bool> updateProfile(String username, String? profilePicUrl) async {
    if (_currentUser == null) {
      _setError('No user logged in');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = _currentUser!.copyWith(
        username: username,
        profilePicUrl: profilePicUrl,
        updatedAt: DateTime.now(),
      );

      await _saveUserToStorage();
      _setLoading(false);
      notifyListeners();

      return true;
    } catch (e) {
      _setError('Profile update failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Get user display name
  String get userDisplayName {
    if (_currentUser == null) return 'User';
    return _currentUser!.displayName;
  }

  // Get user initials
  String get userInitials {
    if (_currentUser == null) return 'U';
    return _currentUser!.initials;
  }

  // Email validation method - ADDED
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Private helper methods
  void _setAuthState(AuthState state) {
    if (_authState != state) {
      _authState = state;
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  final _client = Supabase.instance.client;

  User? get user => _client.auth.currentUser;

  bool get isAuthenticated => user != null;

  AuthViewModel() {
    _client.auth.onAuthStateChange.listen((data) {
      notifyListeners();
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this._repository) {
    _user = _repository.currentUser;

    _authSubscription = _repository.authStateChanges.listen((state) {
      _user = state.session?.user;
      notifyListeners();
    });
  }

  final AuthRepository _repository;

  StreamSubscription<AuthState>? _authSubscription;

  User? _user;
  bool _isLoading = false;

  String? _emailErrorKey;
  String? _passwordErrorKey;
  String? _generalErrorKey;

  User? get currentUser => _user;
  bool get isAuthenticated => _user != null;

  bool get isLoading => _isLoading;
  String? get emailErrorKey => _emailErrorKey;
  String? get passwordErrorKey => _passwordErrorKey;
  String? get generalErrorKey => _generalErrorKey;

  Future<bool> signIn({required String email, required String password}) async {
    final normalizedEmail = email.trim();
    final normalizedPassword = password.trim();

    final isValid = _validateEmailAndPassword(
      email: normalizedEmail,
      password: normalizedPassword,
      validatePasswordLength: false,
    );

    if (!isValid) return false;

    _setLoading(true);

    final result = await _repository
        .signInWithEmailAndPassword(normalizedEmail, normalizedPassword)
        .run();

    _setLoading(false);

    return result.fold(
      (failure) {
        _mapFailureToField(failure);
        notifyListeners();
        return false;
      },
      (user) {
        _user = user;
        clearErrors();
        return true;
      },
    );
  }

  Future<bool> signUp({required String email, required String password}) async {
    final normalizedEmail = email.trim();
    final normalizedPassword = password.trim();

    final isValid = _validateEmailAndPassword(
      email: normalizedEmail,
      password: normalizedPassword,
      validatePasswordLength: true,
    );

    if (!isValid) return false;

    _setLoading(true);

    final result = await _repository
        .signUpWithEmailAndPassword(normalizedEmail, normalizedPassword)
        .run();

    _setLoading(false);

    return result.fold(
      (failure) {
        _mapFailureToField(failure);
        notifyListeners();
        return false;
      },
      (_) {
        clearErrors();
        return true;
      },
    );
  }

  Future<bool> signOut() async {
    _setLoading(true);

    final result = await _repository.signOut().run();

    _setLoading(false);

    return result.fold(
      (failure) {
        _mapFailureToField(failure);
        notifyListeners();
        return false;
      },
      (_) {
        _user = null;
        clearErrors();
        return true;
      },
    );
  }

  void clearErrors() {
    _emailErrorKey = null;
    _passwordErrorKey = null;
    _generalErrorKey = null;
    notifyListeners();
  }

  bool _validateEmailAndPassword({
    required String email,
    required String password,
    required bool validatePasswordLength,
  }) {
    _emailErrorKey = null;
    _passwordErrorKey = null;
    _generalErrorKey = null;

    var isValid = true;

    if (email.isEmpty) {
      _emailErrorKey = 'auth.validation.required_email';
      isValid = false;
    } else if (!_isValidEmail(email)) {
      _emailErrorKey = 'auth.validation.invalid_email';
      isValid = false;
    }

    if (password.isEmpty) {
      _passwordErrorKey = 'auth.validation.required_password';
      isValid = false;
    } else if (validatePasswordLength && password.length < 6) {
      _passwordErrorKey = 'auth.validation.short_password';
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  void _mapFailureToField(AuthFailure failure) {
    _emailErrorKey = null;
    _passwordErrorKey = null;
    _generalErrorKey = null;

    if (failure is InvalidCredentialsAuthFailure) {
      _passwordErrorKey = failure.localizationKey;
      return;
    }

    if (failure is UserAlreadyRegisteredAuthFailure) {
      _emailErrorKey = failure.localizationKey;
      return;
    }

    if (failure is EmailNotConfirmedAuthFailure) {
      _emailErrorKey = failure.localizationKey;
      return;
    }

    _generalErrorKey = failure.localizationKey;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}

import 'package:flutter/foundation.dart';
import 'package:dev_metrics/app/features/auth/data/domain/failures/auth_failure.dart';
import 'package:dev_metrics/app/features/auth/data/repositories/auth_interface_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this._repository);

  final AuthRepository _repository;

  User? _user;

  User? get currentUser => _user;

  bool get isAuthenticated => _user != null;

  bool _isLoading = false;
  String? _emailErrorKey;
  String? _passwordErrorKey;
  String? _generalErrorKey;

  bool get isLoading => _isLoading;
  String? get emailErrorKey => _emailErrorKey;
  String? get passwordErrorKey => _passwordErrorKey;
  String? get generalErrorKey => _generalErrorKey;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
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

  Future<bool> signIn({required String email, required String password}) async {
    final isValid = _validateEmailAndPassword(
      email: email,
      password: password,
      validatePasswordLength: false,
    );

    if (!isValid) return false;

    _setLoading(true);

    final result = await _repository
        .signInWithEmailAndPassword(email, password)
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

  Future<bool> signUp({required String email, required String password}) async {
    final isValid = _validateEmailAndPassword(
      email: email,
      password: password,
      validatePasswordLength: true,
    );

    if (!isValid) return false;

    _setLoading(true);

    final result = await _repository
        .signUpWithEmailAndPassword(email, password)
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

    _generalErrorKey = failure.localizationKey;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }
}

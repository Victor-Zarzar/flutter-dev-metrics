import 'package:dev_metrics/app/features/auth/data/repositories/auth_repository.dart';
import 'package:dev_metrics/app/routes/app_routes.dart';
import 'package:dev_metrics/app/shared/helpers/show_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;

  AuthProvider({required AuthRepository repository}) : _repository = repository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    _setLoading(true);

    final result = await _repository.login(email: email, password: password);

    _setLoading(false);
    result.fold(
      (failure) {
        showToast(context, message: failure.message, status: 'error');
      },
      (user) {
        if (context.mounted) {
          context.go(AppRoutes.home);
        }
      },
    );
  }

  void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);

    final result = await _repository.signUp(
      name: name,
      email: email,
      password: password,
    );

    _setLoading(false);
    result.fold(
      (failure) {
        showToast(context, message: failure.message, status: 'error');
      },
      (user) {
        if (context.mounted) {
          context.go(AppRoutes.home);
        }
      },
    );
  }

  void forgotPassword({
    required BuildContext context,
    required String email,
  }) async {
    _setLoading(true);

    final result = await _repository.forgotPassword(email: email);

    _setLoading(false);
    result.fold(
      (failure) {
        showToast(context, message: failure.message, status: 'error');
      },
      (success) {
        showToast(
          context,
          message: 'Password reset link sent successfully',
          status: 'success',
        );
        if (context.mounted) {
          context.go(AppRoutes.signin);
        }
      },
    );
  }
}

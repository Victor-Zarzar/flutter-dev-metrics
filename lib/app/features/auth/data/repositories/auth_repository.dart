import 'package:dev_metrics/app/features/auth/data/models/user_model.dart';
import 'package:dev_metrics/app/shared/utils/typedefs.dart';

abstract class AuthRepository {
  Stream<AppUser?> get onAuthStateChanged;

  FutureEither<AppUser> login({
    required String email,
    required String password,
  });

  FutureEither<AppUser> signUp({
    required String name,
    required String email,
    required String password,
  });

  FutureEither<void> forgotPassword({required String email});

  FutureEither<void> logout();

  FutureEither<AppUser?> checkAuthState();
}

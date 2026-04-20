import 'package:dev_metrics/app/features/auth/data/domain/failures/auth_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  User? get currentUser;

  Stream<AuthState> get authStateChanges;

  TaskEither<AuthFailure, User> signInWithEmailAndPassword(
    String email,
    String password,
  );

  TaskEither<AuthFailure, User> signUpWithEmailAndPassword(
    String email,
    String password,
  );

  TaskEither<AuthFailure, Unit> signOut();
}

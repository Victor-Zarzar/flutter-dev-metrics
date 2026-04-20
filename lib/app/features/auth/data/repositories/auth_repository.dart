import 'package:dev_metrics/app/features/auth/data/domain/failures/auth_failure.dart';
import 'package:dev_metrics/app/features/auth/data/repositories/auth_interface_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._client);

  final SupabaseClient _client;

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  @override
  TaskEither<AuthFailure, User> signInWithEmailAndPassword(
    String email,
    String password,
  ) {
    return TaskEither.tryCatch(() async {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw const AuthException('Missing user');
      }

      return user;
    }, _mapAuthError);
  }

  @override
  TaskEither<AuthFailure, User> signUpWithEmailAndPassword(
    String email,
    String password,
  ) {
    return TaskEither.tryCatch(() async {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw const AuthException('Missing user');
      }

      return user;
    }, _mapAuthError);
  }

  @override
  TaskEither<AuthFailure, Unit> signOut() {
    return TaskEither.tryCatch(() async {
      await _client.auth.signOut();
      return unit;
    }, _mapAuthError);
  }

  AuthFailure _mapAuthError(Object error, StackTrace stackTrace) {
    if (error is AuthException) {
      final message = error.message.toLowerCase();

      if (message.contains('invalid login credentials')) {
        return const InvalidCredentialsAuthFailure();
      }

      if (message.contains('email not confirmed')) {
        return const EmailNotConfirmedAuthFailure();
      }

      if (message.contains('already registered')) {
        return const UserAlreadyRegisteredAuthFailure();
      }

      return const UnexpectedAuthFailure();
    }

    return const UnexpectedAuthFailure();
  }
}

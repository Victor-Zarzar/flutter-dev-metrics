sealed class AuthFailure {
  const AuthFailure();

  String get localizationKey;
}

class InvalidCredentialsAuthFailure extends AuthFailure {
  const InvalidCredentialsAuthFailure();

  @override
  String get localizationKey => 'auth.errors.invalid_credentials';
}

class EmailNotConfirmedAuthFailure extends AuthFailure {
  const EmailNotConfirmedAuthFailure();

  @override
  String get localizationKey => 'auth.errors.email_not_confirmed';
}

class UserAlreadyRegisteredAuthFailure extends AuthFailure {
  const UserAlreadyRegisteredAuthFailure();

  @override
  String get localizationKey => 'auth.errors.user_already_registered';
}

class UnauthorizedAuthFailure extends AuthFailure {
  const UnauthorizedAuthFailure();

  @override
  String get localizationKey => 'auth.errors.unauthorized';
}

class NetworkAuthFailure extends AuthFailure {
  const NetworkAuthFailure();

  @override
  String get localizationKey => 'auth.errors.network';
}

class UnexpectedAuthFailure extends AuthFailure {
  const UnexpectedAuthFailure();

  @override
  String get localizationKey => 'auth.errors.unexpected';
}

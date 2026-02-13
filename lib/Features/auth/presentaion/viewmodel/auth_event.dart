abstract class AuthEvent {}

class LoginUserNameEvent extends AuthEvent {
  final String email;
  LoginUserNameEvent(this.email);
}

class LoginPasswordEvent extends AuthEvent {
  final String password;
  LoginPasswordEvent(this.password);
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  SignUpEvent(this.name, this.email);
}

class SignUpPasswordEvent extends AuthEvent {
  final String password;
  final String confirmPassword;
  SignUpPasswordEvent(this.password, this.confirmPassword);
}

class VerifyEvent extends AuthEvent {
  final String otp;
  VerifyEvent(this.otp);
}

class ToggleThemeEvent extends AuthEvent {}

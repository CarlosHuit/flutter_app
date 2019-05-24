import 'package:app19022019/core/src/models/auth_response_model.dart';
import 'package:meta/meta.dart';

class LoginUpdateEmail {
  final String email;
  LoginUpdateEmail({@required this.email});
}


class LoginUpdatePassword {
  final String password;
  LoginUpdatePassword({@required this.password});
}


class Login {}

class RemoveLoginError {}

class LoginRestartData { }

class LoginSuccess {
  final AuthResponse authLoginResponse;
  LoginSuccess({@required this.authLoginResponse});
}


class LoginFailed {
  final String error;
  LoginFailed({@required this.error});
}
import '../../models/auth_login_response.dart';
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


class LoginSuccess {
  final AuthLoginResponse authLoginResponse;
  LoginSuccess({@required this.authLoginResponse});
}


class LoginFailed {
  final String error;
  LoginFailed({@required this.error});
}
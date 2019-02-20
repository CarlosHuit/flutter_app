import '../../models/auth_login_response.dart';
import 'package:meta/meta.dart';

class SignupUpdateFirstName {
  final String firstName;
  SignupUpdateFirstName({@required this.firstName});
}


class SignupUpdateLastName {
  final String lastName;
  SignupUpdateLastName({ @required this.lastName});
}


class SignupUpdateEmail {
  final String email;
  SignupUpdateEmail({@required this.email});
}


class SignupUpdatePassword {
  final String password;
  SignupUpdatePassword({@required this.password});
}


class SignupUpdatePassword2 {
  final String password2;
  SignupUpdatePassword2({@required this.password2 });
}


class Signup {}


class SignupSuccess {
  final AuthLoginResponse authLoginResponse;
  SignupSuccess({@required this.authLoginResponse});
}

class SignupFailed {
  final String error;
  SignupFailed({@required this.error});
}

class SignupError {
  final String error;
  SignupError({@required this.error});
}
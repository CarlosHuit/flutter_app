import 'package:app19022019/core/src/models/auth_response_model.dart';
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

class RemoveSignupError {}

class SignupSuccess {
  final AuthResponse authLoginResponse;
  SignupSuccess({@required this.authLoginResponse});
}

class SignupFailed {
  final String error;
  SignupFailed({@required this.error});
}

class SignupRestartData {
  
}

class SignupError {
  final String error;
  SignupError({@required this.error});
}
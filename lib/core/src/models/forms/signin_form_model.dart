
import 'package:meta/meta.dart';

class SigninForm {

  final String email;
  final String password;

  SigninForm({
    @required this.email,
    @required this.password,
  });

  Map<String, String> toJson() {
    return {
      'email':    email,
      'password': password
    };
  }

}
import 'package:meta/meta.dart';

class SignupForm {

  final String email;
  final String password;
  final String password2;
  final String firstName;
  final String lastName;
  final String avatar;

  SignupForm({
    @required this.email,
    @required this.password,
    @required this.password2,
    @required this.firstName,
    @required this.lastName,
    @required this.avatar,
  });

  Map<String, String> toJson() {

    return {
      'email': email,
      'password': password,
      'password2': password2,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
    };

  }

}
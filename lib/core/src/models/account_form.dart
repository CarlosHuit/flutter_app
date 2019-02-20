import 'package:meta/meta.dart';

class AccountForm {

  String firstName;
  String lastName;
  String email;
  String password; 
  String password2;
  String avatar;

  AccountForm(
    {
      @required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.avatar,
      @required this.password,
      @required this.password2,
    }
  );

  AccountForm.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName  = json['lastName'];
    email     = json['email'];
    password  = json['password'];
    password2 = json['password2'];
    avatar    = json['avatar'];
  }

  Map<String, String> toJson() {
    return {
      'firstName':  firstName,
      'lastName':   lastName,
      'email':      email,
      'password':   password,
      'password2':  password2,
      'avatar':      avatar,
    };
  }

  String fullName() => '$firstName $lastName';


}

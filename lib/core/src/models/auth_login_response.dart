import 'package:meta/meta.dart';

class AuthLoginResponse {
  String token;
  String message;
  String userId;
  String firstName;
  String lastName;
  String email;
  String avatar;

  AuthLoginResponse({
    @required this.token,
    @required this.message,
    @required this.userId,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.avatar
  });


  factory AuthLoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    return AuthLoginResponse(
      token     : parsedJson['token'],
      avatar    : parsedJson['avatar'],
      email     : parsedJson['email'],
      firstName : parsedJson['firstName'],
      lastName  : parsedJson['lastName'],
      message   : parsedJson['message'],
      userId    : parsedJson['userId'],

    );
  }

  Map<String, dynamic> toJson() {

    return {
      'token':     token,
      'message':   message,
      'userId':    userId,
      'firstName': firstName,
      'lastName':  lastName,
      'email':     email,
      'avatar':    avatar,
    };

  }


}
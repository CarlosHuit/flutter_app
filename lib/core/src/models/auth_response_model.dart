import 'package:app19022019/core/src/models/models.dart';
import 'package:app19022019/core/src/models/user_model.dart';
import 'package:meta/meta.dart';

class AuthResponse {

  final User user;
  final String token;
  final List<Course> courses;
  final String message;

  AuthResponse({
    @required this.user,
    @required this.token,
    @required this.courses,
    @required this.message
  });

  factory AuthResponse.fromJson(dynamic json) {

    List<Course> courses = [];

    for (var i = 0; i < json['courses'].length; i++) {

      Course el = Course.fromJson(json['courses'][i]);
      courses.add(el);

    }


    return AuthResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
      courses: courses,
      message: json['message'],
    );

  }

  
  Map<String, dynamic> toJson() {

    return {
      'token':     token,
      'message':   message,
      'userId':    user.id,
      'firstName': user.firstName,
      'lastName':  user.lastName,
      'email':     user.email,
      'avatar':    user.avatar,
    };

  }


}
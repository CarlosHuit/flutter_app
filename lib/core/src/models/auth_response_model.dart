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
    print(json);
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

    final coursesList = courses.map((course) =>  course.toJson()).toList();

    return {
      'user':    user.toJson(),
      'token':   token,
      'courses':  coursesList,
      'message': message,
    };

  }


}
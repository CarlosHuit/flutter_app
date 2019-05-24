import 'package:app19022019/core/src/models/models.dart';
import 'package:app19022019/core/src/models/user_model.dart';

class AuthResponse {

  final User user;
  final String token;
  final List<Course> courses;
  final String message;

  AuthResponse(this.user, this.token, this.courses, this.message);


}
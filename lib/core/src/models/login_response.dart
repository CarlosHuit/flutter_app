import './course_model.dart';
import './auth_login_response.dart';




class LoginResponse {

  final AuthLoginResponse auth;
  final List<Course> courses;

  LoginResponse({ this.auth,  this.courses});

  factory LoginResponse.fromJson(dynamic respJson) {

    List<Course> temListCourse = [];

    for (var i = 0; i < respJson['courses'].length; i++) {

      Course el = Course.fromJson(respJson['courses'][i]);
      temListCourse.add(el);

    }

    return LoginResponse(
      auth: AuthLoginResponse(
        token:     respJson['auth']['token'],
        message:   respJson['auth']['message'],
        userId:    respJson['auth']['userId'],
        firstName: respJson['auth']['firstName'],
        lastName:  respJson['auth']['lastName'],
        email:     respJson['auth']['email'],
        avatar:    respJson['auth']['avatar']
      ),
      courses: temListCourse
    );

  }

  Map<String, dynamic> toJson() {

    List tempCourse = [];

    courses.forEach((e) {
      Map<String, String> el = {
        'id':          e.id,
        'title':       e.title,
        'subtitle':    e.subtitle,
        'imageUrl':    e.imageUrl,
        'urlVideo':    e.urlVideo,
        'description': e.description
      };
      tempCourse.add(el);
    });

    return {
      'auth': {
        'token':     auth.token,
        'message':   auth.message,
        'userId':    auth.userId,
        'firstName': auth.firstName,
        'lastName':  auth.lastName,
        'email':     auth.email,
        'avatar':    auth.avatar,
      },
      'courses': tempCourse,
    };

  }


}




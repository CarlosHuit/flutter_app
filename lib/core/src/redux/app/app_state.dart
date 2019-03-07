import 'package:app19022019/core/src/models/auth_login_response.dart';
import 'package:app19022019/core/src/redux/reading_course/reading_course_state.dart';

import '../auth/auth_state.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:meta/meta.dart';
import '../courses/courses_state.dart';
import '../signup/signup_state.dart';
import '../login/login.dart';

@immutable
class AppState {


  final AuthState          authState;
  final LoginState         loginState;
  final SignupState        signupState;
  final String             appName;
  final CoursesState       coursesState;
  final ReadingCourseState readingCourseState;

  AppState({
    @required this.authState,
    @required this.appName,
    @required this.loginState,
    @required this.signupState,
    @required this.coursesState,
    @required this.readingCourseState
  });


  factory AppState.initialState( AuthLoginResponse auth, KeyValueStore keyValueStore) {

    return AppState(
      appName:            'Weduc',
      authState:          AuthState.initialState(auth: auth),
      loginState:         LoginState.initialState(),
      signupState:        SignupState.initialState(),
      coursesState:       CoursesState.initialState(),
      readingCourseState: ReadingCourseState.initialState(),
    );

  }


  AppState copyWith({
    AuthState authState,
    LoginState loginState,
    SignupState signupState,
    CoursesState coursesState,
    ReadingCourseState readingCourseState
  }) {
    return AppState(
      appName:            'Weduc',
      authState:          authState ?? this.authState,
      loginState:         loginState ?? this.loginState,
      signupState:        signupState ?? this.signupState,
      coursesState:       coursesState ?? this.coursesState,
      readingCourseState: readingCourseState ?? this.readingCourseState
    );
  }

  @override
  bool operator == (Object other) =>
    identical(this, other) || other is AppState
      && runtimeType        == other.runtimeType
      && authState          == other.authState
      && appName            == other.appName
      && loginState         == other.loginState
      && signupState        == other.signupState
      && coursesState       == other.coursesState
      && readingCourseState == other.readingCourseState;

  @override
  int get hashCode =>
    authState.hashCode ^
    appName.hashCode ^
    loginState.hashCode ^
    coursesState.hashCode ^
    readingCourseState.hashCode ^
    signupState.hashCode;

}
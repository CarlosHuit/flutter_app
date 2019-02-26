import '../app/app_state.dart';
import '../auth/auth_reducer.dart';
import '../login/login.dart';
import '../signup/signup_reducer.dart';
import '../courses/courses_reducer.dart';
import '../reading_course/reading_course_reduce.dart';

AppState appReducer(AppState state, dynamic action) {

  return new AppState(
    appName: 'Weduc',
    authState:          authReducer(state.authState, action),
    loginState:         loginReducer(state.loginState, action),
    signupState:        signupReducer(state.signupState, action),
    coursesState:       coursesReducer(state.coursesState, action),
    readingCourseState: readingCourseReducer(state.readingCourseState, action)
  );

}
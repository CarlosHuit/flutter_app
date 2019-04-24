import '../app/app_state.dart';
import '../auth/auth_reducer.dart';
import '../login/login.dart';
import '../signup/signup_reducer.dart';
import '../courses/courses_reducer.dart';
import '../reading_course/reading_course_reducer.dart';
import '../device/device_reducer.dart';

AppState appReducer(AppState state, dynamic action) {

  return AppState(
    appName:            'Weduc',
    authState:          authReducer(state.authState, action),
    loginState:         loginReducer(state.loginState, action),
    signupState:        signupReducer(state.signupState, action),
    coursesState:       coursesReducer(state.coursesState, action),
    readingCourseState: readingCourseReducer(state, action),
    deviceState:        deviceReducer(state.deviceState, action)        
  );

}
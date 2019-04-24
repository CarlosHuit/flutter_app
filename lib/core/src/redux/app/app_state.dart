import 'package:flutter/material.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:meta/meta.dart';

import '../reading_course/reading_course_state.dart';
import '../../models/auth_login_response.dart';
import '../courses/courses_state.dart';
import '../signup/signup_state.dart';
import '../auth/auth_state.dart';
import '../login/login.dart';
import '../device/device_state.dart';

@immutable
class AppState {


  final AuthState          authState;
  final LoginState         loginState;
  final SignupState        signupState;
  final String             appName;
  final CoursesState       coursesState;
  final ReadingCourseState readingCourseState;
  final DeviceState        deviceState;

  AppState({
    @required this.authState,
    @required this.appName,
    @required this.loginState,
    @required this.signupState,
    @required this.coursesState,
    @required this.readingCourseState,
    @required this.deviceState,
  });


  factory AppState.initialState( AuthLoginResponse auth, KeyValueStore keyValueStore) {

    return AppState(
      appName:            'Weduc',
      authState:          AuthState.initialState(auth: auth),
      loginState:         LoginState.initialState(),
      signupState:        SignupState.initialState(),
      deviceState:        DeviceState.initialState(),
      coursesState:       CoursesState.initialState(),
      readingCourseState: ReadingCourseState.initialState(),
    );

  }


  AppState copyWith({
    AuthState authState,
    LoginState loginState,
    SignupState signupState,
    DeviceState deviceState,
    CoursesState coursesState,
    ReadingCourseState readingCourseState,
  }) {
    return AppState(
      appName:            'Weduc',
      authState:          authState ?? this.authState,
      loginState:         loginState ?? this.loginState,
      signupState:        signupState ?? this.signupState,
      deviceState:        deviceState ?? this.deviceState,        
      coursesState:       coursesState ?? this.coursesState,
      readingCourseState: readingCourseState ?? this.readingCourseState,
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
      && readingCourseState == other.readingCourseState
      && deviceState        == other.deviceState;

  @override
  int get hashCode =>
    authState.hashCode ^
    appName.hashCode ^
    loginState.hashCode ^
    coursesState.hashCode ^
    readingCourseState.hashCode ^
    signupState.hashCode ^
    deviceState.hashCode;

}
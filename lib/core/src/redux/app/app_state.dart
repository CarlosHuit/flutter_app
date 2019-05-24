import 'package:app19022019/core/src/models/auth_response_model.dart';
import 'package:app19022019/core/src/redux/discussion_system/discussion_system_state.dart';
import 'package:flutter/material.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:meta/meta.dart';

import '../auth/auth_state.dart';
import '../courses/courses_state.dart';
import '../device/device_state.dart';
import '../login/login.dart';
import '../reading_course/reading_course_state.dart';
import '../signup/signup_state.dart';

@immutable
class AppState {


  final AuthState          authState;
  final LoginState         loginState;
  final SignupState        signupState;
  final String             appName;
  final CoursesState       coursesState;
  final ReadingCourseState readingCourseState;
  final DeviceState        deviceState;
  final DiscussionSystemState   discussionSystem;
 
  AppState({
    @required this.authState,
    @required this.appName,
    @required this.loginState,
    @required this.signupState,
    @required this.coursesState,
    @required this.readingCourseState,
    @required this.deviceState,
    @required this.discussionSystem,
  });


  factory AppState.initialState( AuthResponse auth, KeyValueStore keyValueStore) {

    return AppState(
      appName:            'Weduc',
      authState:          AuthState.initialState(auth: auth),
      loginState:         LoginState.initialState(),
      signupState:        SignupState.initialState(),
      deviceState:        DeviceState.initialState(),
      coursesState:       CoursesState.initialState(),
      readingCourseState: ReadingCourseState.initialState(),
      discussionSystem:   DiscussionSystemState.initialState(),
    );

  }


  AppState copyWith({
    AuthState authState,
    LoginState loginState,
    SignupState signupState,
    DeviceState deviceState,
    CoursesState coursesState,
    ReadingCourseState readingCourseState,
    DiscussionSystemState discussionSystem,
  }) {
    return AppState(
      appName:            'Weduc',
      authState:          authState ?? this.authState,
      loginState:         loginState ?? this.loginState,
      signupState:        signupState ?? this.signupState,
      deviceState:        deviceState ?? this.deviceState,        
      coursesState:       coursesState ?? this.coursesState,
      readingCourseState: readingCourseState ?? this.readingCourseState,
      discussionSystem:   discussionSystem ?? this.discussionSystem
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
      && deviceState        == other.deviceState
      && discussionSystem   == other.discussionSystem;

  @override
  int get hashCode =>
    authState.hashCode ^
    appName.hashCode ^
    loginState.hashCode ^
    coursesState.hashCode ^
    readingCourseState.hashCode ^
    signupState.hashCode ^
    deviceState.hashCode ^
    discussionSystem.hashCode;

}
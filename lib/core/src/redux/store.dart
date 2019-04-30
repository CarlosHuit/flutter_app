import 'package:app19022019/core/src/networking/system_discussion_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

import 'package:app19022019/core/src/redux/reading_course/reading_course_middleware.dart';
import 'package:app19022019/core/src/models/auth_login_response.dart';
import 'package:app19022019/core/src/redux/auth/auth_middleware.dart';
import 'package:app19022019/core/src/networking/networking.dart';

import '../redux/discussion_system/discussion_system.dart';
import './navigation/navigation_middleware.dart';
import '../redux/signup/signup_middleware.dart';
import '../redux/login/login_middleware.dart';
import '../redux/courses/courses.dart';
import '../redux/app/app_state.dart';
import './app/app_reducer.dart';


Future<Store<AppState>> createStore({
  @required Client client, @required KeyValueStore keyValueStore, @required FlutterSecureStorage secureStorage }) async {
  
  
  final authJson = await secureStorage.read(key: 'auth');
  final auth = authJson != null ? AuthLoginResponse.fromJson(json.decode(authJson)) : null;


  final readingCourseApi = ReadingCourseApi(client, secureStorage); 
  final coursesApi = CoursesApi(client, secureStorage);
  final authApi    = AuthApi(client);
  final discussionSystemApi = DiscussionSystemApi(client, secureStorage);



  return Store(
    appReducer,
    distinct: true,
    initialState: AppState.initialState( auth, keyValueStore ),
    middleware: [

      LoginMiddleware(authApi),
      SignupMiddleware(authApi),
      AuthMiddleware(secureStorage),
      CoursesMiddleware(coursesApi),
      ReadingCourseMiddleware(readingCourseApi),
      DiscussionSystemMiddleware(discussionSystemApi),
      NavigationMiddleware(),
    ]
  );
  
  
}
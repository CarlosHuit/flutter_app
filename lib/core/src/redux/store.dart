import 'dart:async';
import 'dart:convert';

import 'package:app19022019/core/src/models/auth_response_model.dart';
import 'package:app19022019/core/src/networking/networking.dart';
import 'package:app19022019/core/src/networking/system_discussion_api.dart';
import 'package:app19022019/core/src/redux/auth/auth_middleware.dart';
import 'package:app19022019/core/src/redux/reading_course/reading_course_middleware.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import './app/app_reducer.dart';
import './navigation/navigation_middleware.dart';
import '../redux/app/app_state.dart';
import '../redux/courses/courses.dart';
import '../redux/discussion_system/discussion_system.dart';
import '../redux/login/login_middleware.dart';
import '../redux/signup/signup_middleware.dart';


Future<Store<AppState>> createStore({
  @required Client client, @required KeyValueStore keyValueStore, @required FlutterSecureStorage secureStorage }) async {
  
  
  final authJson = await secureStorage.read(key: 'auth');
  final auth = authJson != null ? AuthResponse.fromJson(json.decode(authJson)) : null;


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
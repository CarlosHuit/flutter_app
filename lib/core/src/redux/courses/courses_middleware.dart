import 'dart:async';
import 'dart:io';

import 'package:app19022019/core/src/redux/auth/auth_actions.dart';
import 'package:app19022019/core/src/redux/navigation/navigation_actions.dart';
import 'package:redux/redux.dart';
import '../../networking/courses_api.dart';
import '../app/app_state.dart';
import './courses_actions.dart';
import '../../models/course_model.dart';

class CoursesMiddleware extends MiddlewareClass<AppState> {

  final CoursesApi api;

  CoursesMiddleware( this.api );

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async{
    next(action);


    if (action is FetchCourses) {

      try {

        final List<Course> courses = await api.fetchCourses();
        store.dispatch(FetchCoursesSuccess(courses: courses));

      } catch (e) {

        if (e is SocketException) {
          store.dispatch(FetchCoursesFailedNoInternet());
        }
        if (e == 'Token invalido') {
          store.dispatch(InvalidAuthCredentials());
        }

      }


    }

    if (action is SetCurrentCourse) {
      await Future.delayed(Duration(milliseconds: 100));
      store.dispatch( NavigatorPushCourseDetail());
    }

  }
  
}
import 'package:app19022019/core/src/networking/courses_api.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class CoursesMiddleware extends MiddlewareClass<AppState> {

  final CoursesApi api;

  CoursesMiddleware({@required this.api});

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    next(action);
  }
  
}
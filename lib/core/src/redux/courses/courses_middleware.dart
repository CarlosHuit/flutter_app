import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class CoursesMiddleware extends MiddlewareClass<AppState> {

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    next(action);
  }
  
}
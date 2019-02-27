import 'package:app19022019/core/src/networking/reading_course_api.dart';
import 'package:app19022019/core/src/redux/reading_course/reading_course_actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import '../app/app_state.dart';

class ReadingCourseMiddleware extends MiddlewareClass<AppState> {

  final ReadingCourseApi api;

  ReadingCourseMiddleware({@required this.api});

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async{

    next(action);

    if (action is RCFetchInitialData) {

      try {
        await api.fetchInitialData();
      } catch (e) {
        print(e);
      }

    }


  }
  
}
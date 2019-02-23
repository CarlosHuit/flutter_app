import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import '../../networking/courses_api.dart';
import '../app/app_state.dart';
import './courses_actions.dart';
import '../../models/course.dart';

class CoursesMiddleware extends MiddlewareClass<AppState> {

  final CoursesApi api;

  CoursesMiddleware({@required this.api});

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async{
    next(action);


    if (action is FetchCourses) {

      try {

        final List<Course> courses = await api.fetchCourses();
        store.dispatch(FetchCoursesSuccess(courses: courses));

      } catch (e) {
        print(e);
        store.dispatch(FetchCoursesFailed(error: e.toString()));

      }

    }

  }
  
}
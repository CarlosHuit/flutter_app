import 'package:app19022019/core/src/models/course.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/courses/courses_actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class HomeViewModel {

  final Function(Course course) setCurrentCourse;
  final List<Course> courses;


  HomeViewModel({
    @required this.courses,
    @required this.setCurrentCourse
  });


  static HomeViewModel fromStore({@required Store<AppState> store}) {

    return HomeViewModel(
      courses:   store.state.coursesState.courses,
      setCurrentCourse: (course) => store.dispatch(SetCurrentCourse(course: course))
    );

  }



  @override
  bool operator == (Object other) =>
  identical(this, other) || other is HomeViewModel
    && runtimeType == other.runtimeType
    && courses     == other.courses;


  @override
  int get hashCode =>
    courses.hashCode;


}
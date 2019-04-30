import 'package:app19022019/core/src/models/course.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../redux/navigation/navigation_actions.dart';

class CourseDetailViewModel {

  final Course course;
  final Function(dynamic action) dispatch;

  CourseDetailViewModel({
    @required this.course,
    @required this.dispatch,
  });


  factory CourseDetailViewModel.fromStore({@required Store<AppState> store}) {

    return CourseDetailViewModel(
      course:   store.state.coursesState.currentCourse,
      dispatch: (action) => store.dispatch(action),
    );

  }

  void startCourse() {
    dispatch(NavigatorReplaceCourse(course: course.subtitle));
  }


  @override
  bool operator == (Object other) =>
  identical(this, other) || other is CourseDetailViewModel
    && runtimeType == other.runtimeType
    && course      == other.course;


  @override
  int get hashCode =>
    course.hashCode;


}
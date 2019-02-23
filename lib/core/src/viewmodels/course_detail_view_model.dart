import 'package:app19022019/core/src/models/course.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class CourseDetailViewModel {

  final Course course;


  CourseDetailViewModel(
    {
      @required this.course
    }
  );


  static CourseDetailViewModel fromStore({@required Store<AppState> store}) {

    return CourseDetailViewModel(
      course: store.state.coursesState.currentCourse,
    );

  }




  @override
  bool operator == (Object other) =>
  identical(this, other) || other is CourseDetailViewModel
    && runtimeType == other.runtimeType
    && course    == other.course;


  @override
  int get hashCode =>
    course.hashCode;


}
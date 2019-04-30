import 'package:app19022019/core/src/models/course.dart';
import 'package:meta/meta.dart';

@immutable
class CoursesState {
  
  final List<Course> courses;
  final Course currentCourse;

  CoursesState({
    @required this.courses,
    @required this.currentCourse
  });

  factory CoursesState.initialState() {
    return CoursesState(
      courses: [],
      currentCourse: null
    );
  }

  CoursesState copyWith({ List<Course> courses, Course currentCourse }) {

    return CoursesState(
      courses: courses ?? this.courses,
      currentCourse: currentCourse != null ? currentCourse : null
    );

  }


  @override
  bool operator == (Object other) => 
  identical(this, other) || other is CoursesState
    && runtimeType == other.runtimeType
    && courses == other.courses
    && currentCourse == other.currentCourse;

  @override
  int get hashCode =>
    courses.hashCode ^ 
    currentCourse.hashCode;

}
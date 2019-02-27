import '../../redux/courses/courses_actions.dart';

import './courses_state.dart';

CoursesState coursesReducer(CoursesState state, dynamic action) {


  if (action is SetCourses) {
    return state.copyWith(courses: action.courses);
  }


  if (action is SetCurrentCourse) {

    return state.copyWith(currentCourse: action.course);
  }

  if (action is UnsetCurrentCourse) {
    return state.copyWith(currentCourse: null);
  }

  if (action is FetchCourses) {
    return state;
  }

  if (action is FetchCoursesSuccess) {
    return state.copyWith( courses: action.courses );
  }

  return state;

}
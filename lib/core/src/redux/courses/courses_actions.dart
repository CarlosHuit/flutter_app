import 'package:app19022019/core/src/models/course.dart';
import 'package:meta/meta.dart';

class SetCourses {
  final List<Course> courses;
  SetCourses({@required this.courses});
}

class SetCurrentCourse {
  final Course course;
  SetCurrentCourse({@required this.course});
}

class FetchCourses {}
class FetchCoursesSuccess {}
class FetchCoursesFailed {}

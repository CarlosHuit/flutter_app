import 'package:app19022019/core/src/models/discussion_system/comment.dart';

class DSGetCourseComments {

  final String courseId;
  DSGetCourseComments(this.courseId);

}

class DSGetCourseCommentsSuccess {

  final List<Comment> comments;
  DSGetCourseCommentsSuccess(this.comments);

}

class DSResetData {}
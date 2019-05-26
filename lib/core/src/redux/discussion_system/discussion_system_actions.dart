import 'package:app19022019/core/src/models/course_model.dart';
import 'package:app19022019/core/src/models/discussion_system/answer.dart';
import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:meta/meta.dart';

class DSGetCourseComments {

  final Course course;
  DSGetCourseComments(this.course);

}

class DSGetCourseCommentsSuccess {

  final List<Comment> comments;
  DSGetCourseCommentsSuccess(this.comments);

}

class DSResetData {}




/*----- actions Add Comment -----*/
class DSAddComment {
  final String text;
  DSAddComment(this.text);
}

class DSAddLocalComment {
  final Comment comment;
  DSAddLocalComment(this.comment);
}

class DSSendComment {
  final Comment comment;
  DSSendComment(this.comment);
}

class DSAddCommentSuccess {
  final Comment comment;
  DSAddCommentSuccess(this.comment);
}

class DSAddCommentError { }




class DSDeleteComment {
  final String commentId;
  DSDeleteComment(this.commentId);
}

class DSDeleteCommentSuccess {
  final String commentId;
  DSDeleteCommentSuccess(this.commentId);
}

class DSRegisterCommetToDelete {
  final String commentId;
  DSRegisterCommetToDelete(this.commentId);
}


/*----- actions Add Answer -----*/
class DSAddAnswer {
  final String text;
  final String commentId;
  DSAddAnswer(this.text, this.commentId);
}

class DSAddLocalAnswer {
  final Answer answer;
  final String commentId;
  DSAddLocalAnswer(this.answer, this.commentId);
}


class DSAddAnswerSuccess {
  final Answer answer;
  final String commentId;
  DSAddAnswerSuccess(this.answer, this.commentId);
}

class DSAddAnswerError {}



/*----- actions Delete Answer -----*/
class DSDeleteAnswer {
  final String commentId;
  final String answerId;

  DSDeleteAnswer({
    @required this.commentId,
    @required this.answerId,
  });

}

class DSRegisterAnswerToDelete {
  final String commentId;
  final String answerId;

  DSRegisterAnswerToDelete(this.commentId, this.answerId);
}


class DSDeleteAnswerSuccess {
  final String commentId;
  final String answerId;

  DSDeleteAnswerSuccess(this.commentId, this.answerId);

}

class DSDeleteAnswerError {}
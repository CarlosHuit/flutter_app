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


class DSAddAnswerSuccess {
  final Answer answer;
  DSAddAnswerSuccess(this.answer);
}

class DSAddAnswerError {}



/*----- actions Delete Answer -----*/
class DSDeleteAnswer {
  final String commentId;
  final String answerId;
  final int index;

  DSDeleteAnswer({
    @required this.commentId,
    @required this.answerId,
    @required this.index
  });

}

class DSDeleteAnswerSuccess {
  final String commentId;
  final List<Answer> answersUpdated;

  DSDeleteAnswerSuccess({
    @required this.commentId,
    @required this.answersUpdated
  });
}

class DSDeleteAnswerError {}
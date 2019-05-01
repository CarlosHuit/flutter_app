import 'package:app19022019/core/src/models/discussion_system/answer.dart';
import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:meta/meta.dart';

class DSGetCourseComments {

  final String courseId;
  DSGetCourseComments(this.courseId);

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

class DSAddCommentSuccess {
  final Comment comment;
  DSAddCommentSuccess(this.comment);
}

class DSAddCommentError { }




/*----- actions Add Answer -----*/
class DSAddAnswer {
  final String text;
  DSAddAnswer(this.text);
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
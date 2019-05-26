import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/discussion_system/discussion_system.dart';
import 'package:app19022019/core/src/redux/discussion_system/discussion_system_state.dart';
import './discussion_system_actions.dart';

DiscussionSystemState discussionSystemReducer(AppState state, dynamic action) {

  if (action is DSGetCourseCommentsSuccess) {
    return DiscussionSystemState.setData(action.comments);
  }

  if (action is DSResetData) {
    return DiscussionSystemState.initialState();
  }

  if (action is DSAddLocalComment) {


    final comments = List<Comment>()..add(action.comment);
    state.discussionSystem.comments.forEach((e) => comments.add(e));


    return state.discussionSystem.copyWith(
      comments: comments,
    );

  }

  if (action is DSRegisterCommetToDelete) {

    final t = state.discussionSystem.commentsToDelete;
    final sd = Map.of(t)..addAll({'${action.commentId}': action.commentId});

    return state.discussionSystem.copyWith(
      commentsToDelete: sd,
    );

  }

  if (action is DSAddCommentSuccess) {

    final comments = state.discussionSystem.comments.map((comment) {
      if (comment.tempId == action.comment.tempId) {
        return comment.addSavedId(action.comment);
      }
      return comment;
    }).toList();

    return state.discussionSystem.copyWith(
      comments: comments,
    );

  }

  if (action is DSDeleteCommentSuccess) {

    final comments = state.discussionSystem.comments.where((c) => c.id != action.commentId).toList();
    final commentsToDelete = {...state.discussionSystem.commentsToDelete};
    commentsToDelete.remove(action.commentId);

    return state.discussionSystem.copyWith(
      comments: comments,
      commentsToDelete: commentsToDelete,
    );
  }

  if (action is DSAddLocalAnswer) {

    final comments = state.discussionSystem.comments.map((c) => c.id == action.commentId ? c.addAnswer(action.answer) : c ).toList();
    print(comments[0].answers);
    return state.discussionSystem.copyWith(
      comments: comments,
    );

  }

  if (action is DSAddAnswerSuccess) {

    final comments = state.discussionSystem.comments.map((c) {

      if (c.id == action.commentId) {
        return c.updateAnswers(action.answer);
      }

      return c;

    }).toList();

    print('replace id');

    return state.discussionSystem.copyWith(
      comments: comments,
    );

  }

  if (action is DSRegisterAnswerToDelete) {

    final t = state.discussionSystem.answersToDelete;
    final sd = Map.of(t)..addAll({'${action.answerId}': action.answerId});
    print(sd);

    return state.discussionSystem.copyWith(
      answersToDelete: sd,
    );

  }

  if (action is DSDeleteAnswerSuccess) {

    final comments = state.discussionSystem.comments.map((c) {

      if (c.id == action.commentId) {
        return c.removeAnswer(action.answerId);
      }

      return c;
      
    }).toList();

    final answersToDelete = {...state.discussionSystem.answersToDelete};
    answersToDelete.remove(action.answerId);

    return state.discussionSystem.copyWith(
      comments: comments,
      answersToDelete: answersToDelete,
    );

  }

  return state.discussionSystem;

}

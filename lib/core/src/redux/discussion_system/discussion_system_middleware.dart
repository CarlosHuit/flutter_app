import 'dart:math';

import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:app19022019/core/src/models/discussion_system/forms/comment_form_model.dart';
import 'package:app19022019/core/src/networking/system_discussion_api.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:redux/redux.dart';

import './discussion_system_actions.dart';

class DiscussionSystemMiddleware extends MiddlewareClass<AppState> {

  final DiscussionSystemApi api;

  DiscussionSystemMiddleware(this.api);

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {


    if (action is DSGetCourseComments) {

      this.getComments(store, action);

    }


    if (action is DSAddComment) {

      this.addComment(store, action, next);

    }

    if (action is DSDeleteComment) {

      next(DSRegisterCommetToDelete(action.commentId));

      final course = store.state.coursesState.currentCourse;
      final commentId = await this.api.deleteComment(course, action.commentId);

      next(DSDeleteCommentSuccess(commentId));

    }

    next(action);

  }



  Future<void> getComments(Store<AppState> store, DSGetCourseComments action ) async {


    if (store.state.discussionSystem.comments == null) {


      try {

        final result = await api.getCommentsCourse(action.course);
        store.dispatch(DSGetCourseCommentsSuccess(result));

      } catch (e) {

        print(e.toString());

      }

      return;

    }


    final comments = store.state.discussionSystem.comments;
    store.dispatch(DSGetCourseCommentsSuccess(comments));

    return;


  }


  Future<void> addComment(Store<AppState> store, dynamic action, NextDispatcher next) async {

    final txt = action.text;
    final user = store.state.authState.user;
    final course = store.state.coursesState.currentCourse;
    final courseId = store.state.coursesState.currentCourse.id;
    final createdAt = DateTime.now();
    final temporaryId = generateTemporaryId(courseId);

    final commentToSave = new CommentForm(
      text:     txt,
      date:     createdAt,
      tempId:   temporaryId,
      userId:   user.id,
      courseId: courseId,
    );

    final comment = new Comment(
      id:      null,
      text:    txt,
      user:    user,
      date:    createdAt,
      tempId:  temporaryId,
      answers: [],
    );


    next(DSAddLocalComment(comment));

    final commentSaved = await this.api.addComment(commentToSave, course);
    print(commentSaved);
    next(DSAddCommentSuccess(commentSaved));

  }

  String generateTemporaryId(String courseId) {
    final rn = Random();
    final randomInt = rn.nextInt(4000);
    return '$courseId$randomInt';
  }

}
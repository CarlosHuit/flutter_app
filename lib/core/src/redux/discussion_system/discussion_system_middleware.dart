import 'dart:math';

import 'package:app19022019/core/src/models/discussion_system/answers.dart';
import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:app19022019/core/src/models/discussion_system/user_data.dart';
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
      getComments(store, action);
    }

    if (action is DSAddComment) {

      final txt = action.text;
      final user = store.state.authState.user;
      final courseId = store.state.coursesState.currentCourse.id;
      final createdAt = DateTime.now();
      final temporaryId = generateTemporaryId(courseId);

      final answers = Answers( commentId: temporaryId, answers: [], id: null );

      final commentToSend = Comment(
        id:       null,
        userId:   user.id,
        user:     null,
        text:     txt,
        date:     createdAt,
        courseId: courseId,
        tempId:   temporaryId,
        answers:  null,
      );

      final u = UserData(id: user.id, email: user.email, avatar: user.avatar, firstName:user.firstName, lastName: user.lastName);

      final localComment = Comment(
        id:       null,
        userId:   null,
        user:     u,
        answers:  answers,
        courseId: courseId,
        date:     createdAt,
        tempId:   temporaryId,
        text:     txt
      );

      print(commentToSend);
      print(localComment);

    }

    next(action);

  }



  Future<void> getComments(Store<AppState> store, dynamic action ) async {

    if (store.state.discussionSystem.comments == null) {

      print('get comments from Server');

      try {

        final result = await api.getAllComments(action.courseId);
        store.dispatch(DSGetCourseCommentsSuccess(result));

      } catch (e) {

        print(e.toString());

      }

      return;

    }


    if (store.state.discussionSystem.comments.length != null) {

      print('get comments from cache');

      final comments = store.state.discussionSystem.comments;
      store.dispatch(DSGetCourseCommentsSuccess(comments));

      return;

    }



  }


  Future<void> addComment(Store<AppState> store, dynamic action) async {



  }

  String generateTemporaryId(String courseId) {
    final rn = Random();
    final randomInt = rn.nextInt(4000);
    return '$courseId$randomInt';
  }

}
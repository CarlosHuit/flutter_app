import 'package:app19022019/core/src/models/discussion_system/comment.dart';
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
      final user = store.state.authState;

      // final commentToSend = Comment(id: null, );
      // final localComment = Comment();

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

}
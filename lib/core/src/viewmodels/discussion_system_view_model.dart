import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/discussion_system/discussion_system_actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class DiscussionSystemViewModel {

  final bool isLoadingComments;
  final List<Comment> comments;

  final String writeAnswerFor;
  final List<String> answersTemporaryIds;
  final List<String> commentsTemporaryIds;
  final Map<String, String> showAnswersOf;
  final Map<String, String> answersToDelete;
  final Map<String, String> commentsToDelete;
  final Function(dynamic action) dispatch;
  final String userId;
  

  DiscussionSystemViewModel({
    @required this.commentsTemporaryIds,
    @required this.answersTemporaryIds,
    @required this.isLoadingComments,
    @required this.commentsToDelete,
    @required this.answersToDelete,
    @required this.writeAnswerFor,
    @required this.showAnswersOf,
    @required this.comments,
    @required this.dispatch,
    @required this.userId,
  });

  factory DiscussionSystemViewModel.fromStore(Store<AppState> store) {

    final ds = store.state.discussionSystem;

    var discussionSystemViewModel = DiscussionSystemViewModel(
      comments:             ds.comments,
      showAnswersOf:        ds.showAnswersOf,
      writeAnswerFor:       ds.writeAnswerFor,
      answersToDelete:      ds.answersToDelete,
      commentsToDelete:     ds.commentsToDelete,
      isLoadingComments:    ds.isLoadingComments,
      answersTemporaryIds:  ds.answersTemporaryIds,
      commentsTemporaryIds: ds.commentsTemporaryIds,
      dispatch:             (action) => store.dispatch(action),
      userId:               store.state.authState.user.id,
    );
    return discussionSystemViewModel;

  }


  void addComment(String term) {

    this.dispatch(DSAddComment(term));

  }


  void deleleComment(String commentId) {

    this.dispatch(DSDeleteComment(commentId));

  }


  void addAnswer(String term, String commentId,) {

    this.dispatch(DSAddAnswer(term, commentId));

  }


  void deleteAnswer(String commentId, String answerId,) {

    this.dispatch( DSDeleteAnswer(commentId: commentId, answerId: answerId ));

  }


  @override
  bool operator == (Object other) => 
    identical(this, other) || other is DiscussionSystemViewModel
      && runtimeType          == other.runtimeType
      && isLoadingComments    == other.isLoadingComments
      && comments             == other.comments
      && userId               == other.userId
      && writeAnswerFor       == other.writeAnswerFor
      && answersTemporaryIds  == other.answersTemporaryIds
      && commentsTemporaryIds == other.commentsTemporaryIds
      && showAnswersOf        == other.showAnswersOf
      && answersToDelete      == other.answersToDelete
      && commentsToDelete     == other.commentsToDelete;


  @override
  int get hashCode => 
    commentsTemporaryIds.hashCode ^
    answersTemporaryIds.hashCode ^ 
    isLoadingComments.hashCode ^ 
    commentsToDelete.hashCode ^
    answersToDelete.hashCode ^ 
    writeAnswerFor.hashCode ^
    showAnswersOf.hashCode ^ 
    comments.hashCode ^
    userId.hashCode;

}
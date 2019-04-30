import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
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
  

  DiscussionSystemViewModel({
    @required this.commentsTemporaryIds,
    @required this.answersTemporaryIds,
    @required this.isLoadingComments,
    @required this.commentsToDelete,
    @required this.answersToDelete,
    @required this.writeAnswerFor,
    @required this.showAnswersOf,
    @required this.comments,
  });

  factory DiscussionSystemViewModel.fromStore(Store<AppState> store) {

    final ds = store.state.discussionSystem;

    return DiscussionSystemViewModel(
      comments:             ds.comments,
      showAnswersOf:        ds.showAnswersOf,
      writeAnswerFor:       ds.writeAnswerFor,
      answersToDelete:      ds.answersToDelete,
      commentsToDelete:     ds.commentsToDelete,
      isLoadingComments:    ds.isLoadingComments,
      answersTemporaryIds:  ds.answersTemporaryIds,
      commentsTemporaryIds: ds.commentsTemporaryIds,
    );

  }

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is DiscussionSystemViewModel
      && runtimeType          == other.runtimeType
      && isLoadingComments    == other.isLoadingComments
      && comments             == other.comments
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
    comments.hashCode;

}
import 'package:app19022019/core/src/models/discussion_system/comment.dart';
import 'package:meta/meta.dart';

@immutable
class DiscussionSystemState {

  final List<Comment> comments;
  final bool isLoadingComments;
  final String writeAnswerFor;
  final List<String> answersTemporaryIds;
  final List<String> commentsTemporaryIds;
  final Map<String, String> showAnswersOf;
  final Map<String, String> answersToDelete;
  final Map<String, String> commentsToDelete;

  DiscussionSystemState({
    this.comments,
    this.isLoadingComments,
    this.writeAnswerFor,
    this.answersTemporaryIds,
    this.commentsTemporaryIds,
    this.showAnswersOf,
    this.answersToDelete,
    this.commentsToDelete
  });

  factory DiscussionSystemState.initialState() {

    return DiscussionSystemState(
      answersTemporaryIds:  null,
      answersToDelete:      null,
      comments:             null,
      commentsTemporaryIds: null,
      commentsToDelete:     null,
      isLoadingComments:    true,
      showAnswersOf:        null,
      writeAnswerFor:       null,
    );

  }

  factory DiscussionSystemState.setData( List<Comment> comments) {

    return DiscussionSystemState(
      commentsTemporaryIds: [],
      answersTemporaryIds: [],
      isLoadingComments:  false,
      commentsToDelete:  Map(),
      answersToDelete:  Map(),
      showAnswersOf:   Map(),
      writeAnswerFor: '',
      comments:      comments,
    );

  }

  DiscussionSystemState copyWith({
    List<Comment> comments,
    bool isLoadingComments,
    String writeAnswerFor,
    List<String> answersTemporaryIds,
    List<String> commentsTemporaryIds,
    Map<String, String> showAnswersOf,
    Map<String, String> answersToDelete,
    Map<String, String> commentsToDelete,
  }) {

    return DiscussionSystemState(
      comments:             comments ?? this.comments,
      showAnswersOf:        showAnswersOf ?? this.showAnswersOf,
      writeAnswerFor:       writeAnswerFor ?? this.writeAnswerFor,
      answersToDelete:      answersToDelete ?? this.answersToDelete,
      commentsToDelete:     commentsToDelete ?? this.commentsToDelete,
      isLoadingComments:    isLoadingComments ?? this.isLoadingComments,
      answersTemporaryIds:  answersTemporaryIds ?? this.answersTemporaryIds,
      commentsTemporaryIds: commentsTemporaryIds ?? this.commentsTemporaryIds,
    );

  }

  @override
  bool operator == (Object other) => 
    identical(this, other) || other is DiscussionSystemState
      && runtimeType          == other.runtimeType
      && comments             == other.comments
      && isLoadingComments    == other.isLoadingComments
      && writeAnswerFor       == other.writeAnswerFor
      && answersTemporaryIds  == other.answersTemporaryIds
      && commentsTemporaryIds == other.commentsTemporaryIds
      && showAnswersOf        == other.showAnswersOf
      && answersToDelete      == other.answersToDelete
      && commentsToDelete     == other.commentsToDelete;

  @override
  int get hashCode => 
    comments.hashCode ^
    isLoadingComments.hashCode ^
    writeAnswerFor.hashCode ^
    answersTemporaryIds.hashCode ^
    commentsTemporaryIds.hashCode ^
    showAnswersOf.hashCode ^
    answersToDelete.hashCode ^
    commentsToDelete.hashCode;

}
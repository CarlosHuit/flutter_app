import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/discussion_system/discussion_system_state.dart';
import './discussion_system_actions.dart';

DiscussionSystemState discussionSystemReducer(AppState state, dynamic action) {

  if (action is DSGetCourseCommentsSuccess) {
    return DiscussionSystemState.setData(action.comments);
  }

  if (action is DSResetData) {
    return DiscussionSystemState.initialState();
  }

  return state.discussionSystem;

}

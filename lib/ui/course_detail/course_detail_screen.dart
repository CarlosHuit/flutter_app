
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/courses/courses_actions.dart';
import 'package:app19022019/core/src/redux/discussion_system/discussion_system_actions.dart';
import 'package:app19022019/core/src/viewmodels/course_detail_view_model.dart';

import './course_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CourseDetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, CourseDetailViewModel>(

      distinct:  true,
      onDispose: (store) {
        store.dispatch(UnsetCurrentCourse());
        store.dispatch(DSResetData());
      },
      converter: (store) => CourseDetailViewModel.fromStore(store: store),
      builder:   (_, viewModel) => CourseDetailContent(viewModel: viewModel),

    );

  }


}

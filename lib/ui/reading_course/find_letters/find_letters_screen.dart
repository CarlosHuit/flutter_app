import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_find_letters/rc_find_letters_actions.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/find_letters_view_model.dart';
import 'package:app19022019/ui/reading_course/find_letters/find_letters_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FindLettersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, FindLettersViewModel>(

      onInit:    (store) => store.dispatch(RCSetInitialDataFL()),
      converter: (store) => FindLettersViewModel.fromStore(store),
      builder:   (_, vm) {

        return PageView.builder(
          itemCount: vm.data.length,
          itemBuilder: (_, i) => FindLettersPage( data: vm.data[i] )
        );

      },

    );

  }


}


import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_letter_detail/rc_letter_detail_actions.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/reading_course/letter_detail/letter_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LetterDetailScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, LetterDetailViewModel>(
      distinct:  true,
      onInit:    (store) => store.dispatch(RCSetInitialDataLD()),
      onDispose: (store) => store.dispatch(RCResetDataLD()),
      converter: (store) => LetterDetailViewModel.fromStore(store),
      builder:   (_, vm) => WillPopScope(
        onWillPop: cancelTts,
        child: LetterDetailContent(vm: vm)
      )

    );

  }

  Future<bool> cancelTts() async{
    SpeechSynthesisService.stop();
    return true;
  }

}

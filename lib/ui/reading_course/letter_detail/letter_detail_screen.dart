import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/reading_course/letter_detail/letter_detail_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LetterDetailScreen extends StatefulWidget {
  @override
  _LetterDetailScreenState createState() => _LetterDetailScreenState();
}

class _LetterDetailScreenState extends State<LetterDetailScreen> {
 
  final SpeechSynthesisService tts = SpeechSynthesisService();

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, LetterDetailViewModel>(
      distinct:  true,
      onDispose: (store) =>  tts.cancel(),
      converter: (store) => LetterDetailViewModel.fromStore(store),
      builder:   (_, vm) => Scaffold( body: LetterDetailBody(vm: vm) )

    );

  }


}

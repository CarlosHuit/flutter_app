import 'dart:async';

import 'package:app19022019/core/src/redux/reading_course/rc_letter_detail/rc_letter_detail_actions.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_letter_detail/rc_letter_detail_state.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/reading_course/letter_detail/letter_detail_body.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/ui/reading_course/letter_detail/letter_modal.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';

class LetterDetailScreen extends StatefulWidget {
  @override
  _LetterDetailScreenState createState() => _LetterDetailScreenState();
}

class _LetterDetailScreenState extends State<LetterDetailScreen> {
 
  final SpeechSynthesisService tts = SpeechSynthesisService();
  Function() cb1;
  Function() cb2;

  @override
  void initState() {

    Future.delayed(Duration(milliseconds: 0), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle( statusBarColor: Colors.transparent ));
    });

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle( statusBarColor: Colors.black12 )
    );
    cb1 = null;
    cb2 = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, LetterDetailViewModel>(
      distinct:  true,
      onInit:    (store) {


        this.cb1 = () => store.dispatch(RCShowAllCardsLD());
        this.cb2 = () => store.dispatch(RCHideAllCardsLD());


        final data = store.state.readingCourseState.letterDetail.currentData;
        Future.delayed(Duration(milliseconds: 500), () => _showModalSheet(data));

      },
      onDispose: (store) =>  tts.cancel(),
      converter: (store) => LetterDetailViewModel.fromStore(store),
      builder:   (BuildContext _, LetterDetailViewModel vm) {

        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () => _showModalSheet(vm.data),
          //   child:     Icon(Icons.arrow_upward, size: 28.0,),
          //   mini:      true,
          // ),
          body: LetterDetailBody(vm: vm)
        );

      },
    );

  }

  

  void _showModalSheet(SLData data) {
    
    final initialMsg = 'Esta es la letra: ${data.letterSound} ${data.type}';
    final finalMsg   = 'Encuentra la pareja de letras: ${data.letterSound} ${data.type}';

    tts.speak(term: initialMsg);

    showModalBottomSheet(

      context: context,
      builder: (_) => LetterModal(letter: data.letter)

    ).whenComplete(() {
      tts.speak(term: finalMsg);
      cb1();
      Future.delayed(Duration(milliseconds: 3000), () => cb2());
    });

  }


}


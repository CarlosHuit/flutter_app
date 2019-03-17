import 'dart:async';

import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/reading_course/letter_detail/letter_detail_body.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';

class LetterDetailScreen extends StatefulWidget {
  @override
  _LetterDetailScreenState createState() => _LetterDetailScreenState();
}

class _LetterDetailScreenState extends State<LetterDetailScreen> {
 
  final SpeechSynthesisService tts = SpeechSynthesisService();

  @override
  void initState() {

    Future.delayed(Duration(milliseconds: 0), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle( statusBarColor: Colors.transparent )
      );
    });

    super.initState();
  }

  @override
  void dispose() {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black12)
    );

    super.dispose();
  }

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


// floatingActionButton: FloatingActionButton(
//   onPressed: () => _showModalSheet(vm.data),
//   child:     Icon(Icons.arrow_upward, size: 28.0,),
//   mini:      true,
// ),

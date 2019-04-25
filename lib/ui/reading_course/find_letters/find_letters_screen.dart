import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_find_letters/rc_find_letters_actions.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/find_letters_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './find_letters_content.dart';

class FindLettersScreen extends StatefulWidget {

  @override
  _FindLettersScreenState createState() => _FindLettersScreenState();

}

class _FindLettersScreenState extends State<FindLettersScreen> {


  PageController pageController;

  @override
  void initState() {

    super.initState();
    pageController = PageController();

  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, FindLettersViewModel>(

      distinct:  true,
      onInit:    (store) => store.dispatch(RCSetInitialDataFL()),
      onDispose: (store) => store.dispatch(RCResetDataFL()),
      converter: (store) => FindLettersViewModel.fromStore(store),
      builder:   (_, vm) {
        return WillPopScope(
          onWillPop: cancelTts,
          child: FIndLettersContent(viewModel: vm),
        );

      }

    );

  }

  Future<bool> cancelTts() async{
    SpeechSynthesisService.stop();
    return true;
  }


}


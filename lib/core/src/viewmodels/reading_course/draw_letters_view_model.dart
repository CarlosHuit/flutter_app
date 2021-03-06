import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/navigation/navigation_actions.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_draw_letters/rc_draw_letters.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/ui/reading_course/select_words/select_words_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:page_transition/page_transition.dart';
import 'package:redux/redux.dart';

@immutable
class DrawLettersViewModel {
  
  final SpeechSynthesisService tts = SpeechSynthesisService();

  final List<RCDrawLetterData> data;
  final RCDrawLetterData currrentData;
  final bool isSettingData;
  final bool showWellDoneDialog;
  final RCDrawLetterPreferences preferences;
  final RCDrawLetterConfigData configData;
  final int currentIndex;
  final bool showHandWriting;
  final RCDrawLettersTopControlBar topControlBar;

  final Function(dynamic action) dispatch;

  DrawLettersViewModel({
    @required this.data,
    @required this.currrentData,
    @required this.isSettingData,
    @required this.showWellDoneDialog,
    @required this.preferences,
    @required this.configData,
    @required this.currentIndex,
    @required this.showHandWriting,
    @required this.dispatch,
    @required this.topControlBar,
  });

  factory DrawLettersViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState.drawLetters;

    return DrawLettersViewModel(
      data:               path.data,
      configData:         path.configData,
      preferences:        path.preferences,
      currentIndex:       path.currentIndex,
      currrentData:       path.currrentData,
      isSettingData:      path.isSettingData,
      showHandWriting:    path.showHandWriting,
      showWellDoneDialog: path.showWellDoneDialog,
      topControlBar:      path.topControlBar,
      dispatch:           (action) => store.dispatch(action),
    );
  }


  void toggleStrokeSizeSelector() => dispatch(RCToggleStrokeSizeSelectorDL());


  void toggleStrokeColorSelector() => dispatch(RCToggleStrokeColorSelectorDL());


  void changeStrokeSize(double width) => dispatch(RCChangeStrokeSizeDL(width));


  void changeStrokeColor(Color color) => dispatch(RCChangeStrokeColorDL(color));


  void toggleGuideLines() => dispatch(RCToggleGuideLines());


  void handWrintingMessage() {

    final letter = currrentData.soundLetter;
    final type   = currrentData.type;
    final message = ' Mira atentamente, así se escribe la letra: $letter $type';

    tts.speak(message);

  }


  void handwritingErrorMessage() {
    
    final sound = currrentData.soundLetter;
    final type = currrentData.type;
    final msg = 'Por ahora no puedo mostrarte cómo se escribe la letra: $sound $type';
    tts.speak(msg);
  }


  void blackboardInstructions() {

    final letter = currrentData.soundLetter;
    final type = currrentData.type;
    final message = 'Bien, ahora practica escribir la letra: $letter $type';

    tts.speak(message);

  }


  void validateTraces() {

    final isCorrect = true;

    if (isCorrect) {

      dispatch(RCShowWellDoneDialogDL());

    }

    if(!isCorrect) {
      /// retry strokes
    }



  }


  void onHideWellDoneDialog() async{

    await dispatch(RCHideWellDoneDialogDL());

    if ( currentIndex < data.length - 1 )
      changeCurrentData();
    else
      redirect();

  }  


  void changeCurrentData() {
    dispatch(RCChangeCurrentDataDL());
  }


  void redirect() {
    dispatch(
      NavigatorPushReplaceWithTransition(
        screen: SelectWordsScreen(),
        transition: PageTransitionType.rightToLeft
      )
    );
  }


  void speakOnWellDone() {
    tts.speak('Bien Hecho');
  }

  void showHandwriting() {
    dispatch(RCShowHandwritingDL());
  }

  void hideHandwriting() {
    dispatch(RCHideHandwritingDL());
  }



  @override
  bool operator ==(Object other) =>
    identical(this, other)  || other is DrawLettersViewModel
      && runtimeType        == other.runtimeType
      && data               == other.data
      && currrentData       == other.currrentData
      && isSettingData      == other.isSettingData
      && showWellDoneDialog == other.showWellDoneDialog
      && preferences        == other.preferences
      && configData         == other.configData
      && currentIndex       == other.currentIndex
      && showHandWriting    == other.showHandWriting
      && topControlBar      == other.topControlBar;

  @override
  int get hashCode =>
    data.hashCode ^
    currrentData.hashCode ^
    isSettingData.hashCode ^
    showWellDoneDialog.hashCode ^
    preferences.hashCode ^
    configData.hashCode ^
    currentIndex.hashCode ^
    showHandWriting.hashCode ^
    topControlBar.hashCode;

}
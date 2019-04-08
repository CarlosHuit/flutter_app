import 'dart:async';

import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/navigation/navigation_actions.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_letter_detail/rc_letter_detail.dart';
import 'package:app19022019/core/src/services/audio_service.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:app19022019/ui/reading_course/game/game_screen.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class LetterDetailViewModel {

  final SpeechSynthesisService tts = SpeechSynthesisService(); 

  final SLData       data;
  final String       letter;
  final List<String> options;
  final String       typeLetter;
  final SLSelections selections;
  final String       selection1;
  final String       selection2;
  final bool         canPlayGame;
  final String       letterSound;
  final bool         showAllCards;
  final bool         hideAllCards;
  final int          currentIndex;
  final int          dataLength;

  final bool showTryAgainDialog;
  final bool showWellDoneDialog;

  final Function(dynamic action) dispatch;

  LetterDetailViewModel( {

    @required this.letter,
    @required this.options,
    @required this.typeLetter,
    @required this.showAllCards,
    @required this.hideAllCards,
    @required this.canPlayGame,
    @required this.selections,
    @required this.selection1,
    @required this.selection2,
    @required this.data,
    @required this.letterSound,
    @required this.dispatch,
    @required this.showTryAgainDialog,
    @required this.showWellDoneDialog,
    @required this.currentIndex,
    @required this.dataLength,
  });


  factory LetterDetailViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState;

    return LetterDetailViewModel(
      data:         path.letterDetail.currentData,
      letter:       path.letterDetail.currentData.letter,
      options:      path.letterDetail.currentData.data,
      selections:   path.letterDetail.selections,
      typeLetter:   path.letterDetail.currentData.type,
      selection1:   path.letterDetail.selections.selection1,
      selection2:   path.letterDetail.selections.selection2,
      canPlayGame:  path.letterDetail.canPlayGame,
      showAllCards: path.letterDetail.showAllCards,
      hideAllCards: path.letterDetail.hideAllCards,
      letterSound:  path.data.soundLetters[path.letterDetail.currentData.letter.toLowerCase()],
      currentIndex: path.letterDetail.currentIndex,
      dataLength:   path.letterDetail.data.length,
      dispatch:          (action) => store.dispatch(action),
      showTryAgainDialog: path.letterDetail.showTryAgainDialog,
      showWellDoneDialog: path.letterDetail.showWellDoneDialog,
    );

  }


  void selectOption(String option) async{


    if (option[0] == letter) {
      tts.speak(term: '$letterSound $typeLetter', rate: 1.0);
    } else {
      tts.cancel();
      AudioService.playAsset(AudioType.incorrect);
    }



    if (selection1 == null) {
      dispatch(RCAddFirstSelectionLD(option));
    }

    if (selection1!= null ) {

      dispatch(RCAddSecondSelectionLD(option));
      Future.delayed(
        Duration(milliseconds: 1200),
        () => dispatch(RCValidateSelectionsLD())
      );

    }


  }

  void listenCorrectMsg() {
    tts.speak(term: 'Bien Hecho');
  }

  void listenIncorrectMsg() {
    tts.speak(term: 'Inténtalo nuevamente');
  }

  void hideTryAgainDialog() {
    dispatch(RCHideTryAgainDialogLD());
  }

  void hideWellDoneDialog() {
    dispatch(RCHideWellDoneDialogLD());
  }

  void changeCurrentData() {

    if (currentIndex < dataLength - 1) {

      dispatch(RCChangeCurrentDataLD());
    } else {

      dispatch(NavigatorPushReplaceRigthToLeft(GameScreen()));
    }

  }

  void dispatchShowAllCards() {
    dispatch(RCShowAllCardsLD());
  }

  void dispatchHideAllCards() {
    dispatch(RCHideAllCardsLD());
  }


  void modalSheetIMsg() {
    final iMsg = 'Esta es la letra: ${data.letterSound} ${data.type}';
    tts.speak(term: iMsg);
  }

  void modalSheetFMsg() {
    final fMsg   = 'Encuentra la pareja de letras: ${data.letterSound} ${data.type}';
    tts.speak(term: fMsg);
  }

  @override
  bool operator == (Object other) => 
  identical(this, other) || other is LetterDetailViewModel
    && runtimeType         == other.runtimeType
    && letter              == other.letter
    && options             == other.options
    && showAllCards        == other.showAllCards
    && hideAllCards        == other.hideAllCards
    && canPlayGame         == other.canPlayGame
    && selections          == other.selections
    && selection1          == other.selection1
    && selection2          == other.selection2
    && data                == other.data
    && letterSound         == other.letterSound
    && showTryAgainDialog  == other.showTryAgainDialog
    && showWellDoneDialog  == other.showWellDoneDialog
    && currentIndex        == other.currentIndex
    && dataLength          == other.dataLength
    && typeLetter          == other.typeLetter;

  @override
  int get hashCode =>
    data.hashCode ^
    letter.hashCode ^
    options.hashCode ^
    selections.hashCode ^
    selection1.hashCode ^
    selection2.hashCode ^
    canPlayGame.hashCode ^
    letterSound.hashCode ^
    showAllCards.hashCode ^
    hideAllCards.hashCode ^
    showTryAgainDialog.hashCode ^
    showWellDoneDialog.hashCode ^
    currentIndex.hashCode ^
    dataLength.hashCode ^
    typeLetter.hashCode;

}
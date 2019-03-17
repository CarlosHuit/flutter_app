import 'dart:async';

import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_letter_detail/rc_letter_detail.dart';
import 'package:app19022019/core/src/services/audio_service.dart';
import 'package:app19022019/core/src/services/speech_synthesis_service.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class LetterDetailViewModel {
  
  SpeechSynthesisService tts = SpeechSynthesisService(); 

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
      selections:         path.letterDetail.selections,
      data:               path.letterDetail.currentData,
      canPlayGame:        path.letterDetail.canPlayGame,
      showAllCards:       path.letterDetail.showAllCards,
      hideAllCards:       path.letterDetail.hideAllCards,
      options:            path.letterDetail.currentData.data,
      typeLetter:         path.letterDetail.currentData.type,
      letter:             path.letterDetail.currentData.letter,
      selection1:         path.letterDetail.selections.selection1,
      selection2:         path.letterDetail.selections.selection2,
      showTryAgainDialog: path.letterDetail.showTryAgainDialog,
      showWellDoneDialog: path.letterDetail.showWellDoneDialog,
      letterSound:        path.data.soundLetters[path.letterDetail.currentData.letter.toLowerCase()],
      dispatch:          (action) => store.dispatch(action),
      currentIndex:       path.letterDetail.currentIndex,
      dataLength:         path.letterDetail.data.length
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
      print('Change CurrentData');
      dispatch(RCChangeCurrentDataLD());
    } else {
      print('redirect');
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
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
    @required this.showWellDoneDialog
  });


  factory LetterDetailViewModel.fromStore(Store<AppState> store) {

    final path = store.state.readingCourseState.letterDetail;

    return LetterDetailViewModel(
      selections:   path.selections,
      data:         path.currentData,
      canPlayGame:  path.canPlayGame,
      showAllCards: path.showAllCards,
      hideAllCards: path.hideAllCards,
      options:      path.currentData.data,
      typeLetter:   path.currentData.type,
      letter:       path.currentData.letter,
      selection1:   path.selections.selection1,
      selection2:   path.selections.selection2,
      letterSound:  store.state.readingCourseState.data.soundLetters[path.currentData.letter.toLowerCase()],
      dispatch:     (action) => store.dispatch(action),
      showTryAgainDialog: store.state.readingCourseState.letterDetail.showTryAgainDialog,
      showWellDoneDialog: store.state.readingCourseState.letterDetail.showWellDoneDialog,
    );

  }


  void selectOption(String option) async{


    if (option[0] == letter) {
      tts.speak(term: '$letterSound $typeLetter', rate: 1.0);
    } else {
      AudioService.playAsset(AudioType.incorrect);
    }



    if (selection1 == null) {
      dispatch(RCAddFirstSelectionLD(option));
    }

    if (selection1!= null ) {

      dispatch(RCAddSecondSelectionLD(option));
      dispatch(RCValidateSelectionsLD());

    }


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
    && typeLetter          == other.typeLetter;

  @override
  int get hashCode =>
    letter.hashCode ^
    options.hashCode ^
    showAllCards.hashCode ^
    hideAllCards.hashCode ^
    canPlayGame.hashCode ^
    selections.hashCode ^
    selection1.hashCode ^
    selection2.hashCode ^
    data.hashCode ^
    letterSound.hashCode ^
    showTryAgainDialog.hashCode ^
    showWellDoneDialog.hashCode ^
    typeLetter.hashCode;

}
import 'package:app19022019/core/src/redux/reading_course/reading_course_state.dart';
import 'package:meta/meta.dart';

@immutable
class RCLetterDetailState {

  final List<SLData> data;
  final SLSelections selections;
  final int    currentIndex;
  final SLData currentData;
  final bool   isSettingData;
  final bool   showAllCards;
  final bool   hideAllCards;
  final bool   canPlayGame;
  final bool   showSuccessScreen;
  final bool   showTryAgainDialog;
  final bool   showWellDoneDialog;
  final bool   showModal;

  RCLetterDetailState({
    @required this.data,
    @required this.selections,
    @required this.canPlayGame,
    @required this.currentData,
    @required this.currentIndex,
    @required this.showAllCards,
    @required this.hideAllCards,
    @required this.isSettingData,
    @required this.showSuccessScreen,
    @required this.showWellDoneDialog,
    @required this.showTryAgainDialog,
    @required this.showModal,
  });

  factory RCLetterDetailState.initialState() {
    return RCLetterDetailState(
      data:               null,
      showModal:          null,
      selections:         null,
      canPlayGame:        null,
      currentData:        null,
      currentIndex:       null,
      hideAllCards:       null,
      isSettingData:      null,
      showAllCards:       null,
      showSuccessScreen:  null,
      showWellDoneDialog: null,
      showTryAgainDialog: null,
    );
  }

  factory RCLetterDetailState.fromStore(ReadingCourseState store) {

    final letterLC = store.data.currentLetter.toLowerCase();
    final letterUC = store.data.currentLetter.toUpperCase();
    final letterSound = store.data.soundLetters[letterLC];

    final slLowerCase = List.of(
      store.data.similarLetters.firstWhere((x) => x.l == letterLC).sl);

    final slUpperCase = List.of(
      store.data.similarLetters.firstWhere((x) => x.l == letterUC).sl);

    for (var i = 0; i < 3; i++) {
      slLowerCase.add(slLowerCase[i]);
      slUpperCase.add(slUpperCase[i]);
    }

    for (var i = 0; i < 2; i++) {
      slLowerCase.add(letterLC);
      slUpperCase.add(letterUC);
    }


    slLowerCase.shuffle();
    slUpperCase.shuffle();

    final dataLowerCase = SLData(letterLC, slLowerCase, 'minúscula', letterSound);
    final dataUpperCase = SLData(letterUC, slUpperCase, 'mayúscula', letterSound);
    final selections    = SLSelections(selection1: null, selection2: null);
    final data          = [ dataLowerCase, dataUpperCase ];

    return RCLetterDetailState(
      currentIndex:       0,
      data:               data,
      selections:         selections,
      currentData:        dataLowerCase,
      canPlayGame:        false,
      hideAllCards:       true,
      showAllCards:       false,
      isSettingData:      false,
      showSuccessScreen:  false,
      showTryAgainDialog: false,
      showWellDoneDialog: false,
      showModal:          true,
    );

  }



  RCLetterDetailState copyWith({
    SLSelections selections,
    List<SLData> data,
    SLData currentData,
    bool isSettingData,
    bool showAllCards,
    bool hideAllCards,
    bool canPlayGame,
    bool showSuccessScreen,
    int currentIndex,
    bool showTryAgainDialog,
    bool showWellDoneDialog,
    bool showModal,
  }) {
    return RCLetterDetailState(
      data:               data               ?? this.data,
      showModal:          showModal          ?? this.showModal,
      currentIndex:       currentIndex       ?? this.currentIndex,
      currentData:        currentData        ?? this.currentData,
      selections:         selections         ?? this.selections,
      isSettingData:      isSettingData      ?? this.isSettingData,
      showAllCards:       showAllCards       ?? this.showAllCards,
      hideAllCards:       hideAllCards       ?? this.hideAllCards,
      canPlayGame:        canPlayGame        ?? this.canPlayGame,
      showSuccessScreen:  showSuccessScreen  ?? this.showSuccessScreen,
      showTryAgainDialog: showTryAgainDialog ?? this.showTryAgainDialog,
      showWellDoneDialog: showWellDoneDialog ?? this.showWellDoneDialog,
    );
  }

  @override
  bool operator == (Object other) =>
    identical( this, other) || other is RCLetterDetailState
      && runtimeType        == other.runtimeType
      && data               == other.data
      && selections         == other.selections
      && canPlayGame        == other.canPlayGame
      && currentData        == other.currentData
      && currentIndex       == other.currentIndex
      && showAllCards       == other.showAllCards
      && hideAllCards       == other.hideAllCards
      && isSettingData      == other.isSettingData
      && showTryAgainDialog == other.showTryAgainDialog
      && showWellDoneDialog == other.showWellDoneDialog
      && showSuccessScreen  == other.showSuccessScreen
      && showModal          == other.showModal;

  @override
  int get hashCode => 
    data.hashCode ^
    selections.hashCode ^
    canPlayGame.hashCode ^
    currentData.hashCode ^
    currentIndex.hashCode ^
    showAllCards.hashCode ^
    hideAllCards.hashCode ^
    isSettingData.hashCode ^
    showTryAgainDialog.hashCode ^
    showWellDoneDialog.hashCode ^
    showSuccessScreen.hashCode ^
    showModal.hashCode;

}



class SLData {

  final String letter;
  final List<String> data;
  final String type;
  final String letterSound;

  SLData(this.letter, this.data, this.type, this.letterSound);


  Map<String, dynamic> toJson() {
    return {
      'letter':      letter,
      'data':        data,
      'type':        type,
      'letterSound': letterSound
    };
  }


}



class SLSelections {

  final String selection1;
  final String selection2;

  SLSelections({ this.selection1, this.selection2 });

  SLSelections copyWith({
    String selection1,
    String selection2,
  }) {
    return SLSelections(
      selection1: selection1 ?? this.selection1,
      selection2: selection2 ?? this.selection2
    );
  }

  SLSelections restart() {
    return SLSelections(
      selection1: null,
      selection2: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selection1': selection1,
      'selection2': selection2
    };
  }


}

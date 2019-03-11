import 'package:app19022019/core/src/redux/reading_course/reading_course_state.dart';
import 'package:meta/meta.dart';

@immutable
class RCLetterDetailState {

  final List<SLData> data;
  final SLSelections selections;
  final int          currentIndex;
  final SLData       currentData;
  final bool         isSettingData;
  final bool         showAllCards;
  final bool         hideAllCards;
  final bool         canPlayGame;
  final bool         showSuccessScreen;

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

  });

  factory RCLetterDetailState.initialState() {
    return RCLetterDetailState(
      canPlayGame:       null,
      currentData:       null,
      currentIndex:      null,
      data:              null,
      hideAllCards:      null,
      isSettingData:     null,
      selections:        null,
      showAllCards:      null,
      showSuccessScreen: null,
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


    return RCLetterDetailState(
      canPlayGame:       false,
      currentData:       dataLowerCase,
      currentIndex:      0,
      data:              [ dataLowerCase, dataUpperCase ],
      hideAllCards:      true,
      showAllCards:      false,
      isSettingData:     false,
      selections:        SLSelections(selection1: null, selection2: null),
      showSuccessScreen: false
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
  }) {
    return RCLetterDetailState(
      data:              data              ?? this.data,
      currentIndex:      currentIndex      ?? this.currentIndex,
      currentData:       currentData       ?? this.currentData,
      selections:        selections        ?? this.selections,
      isSettingData:     isSettingData     ?? this.isSettingData,
      showAllCards:      showAllCards      ?? this.showAllCards,
      hideAllCards:      hideAllCards      ?? this.hideAllCards,
      canPlayGame:       canPlayGame       ?? this.canPlayGame,
      showSuccessScreen: showSuccessScreen ?? this.showSuccessScreen,
    );
  }

  @override
  bool operator == (Object other) =>
    identical(this, other) || other is RCLetterDetailState
      && runtimeType       == other.runtimeType
      && data              == other.data
      && selections        == other.selections
      && canPlayGame       == other.canPlayGame
      && currentData       == other.currentData
      && currentIndex      == other.currentIndex
      && showAllCards      == other.showAllCards
      && hideAllCards      == other.hideAllCards
      && isSettingData     == other.isSettingData
      && showSuccessScreen == other.showSuccessScreen;

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
    showSuccessScreen.hashCode;

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
  // @override
  // bool operator == (Object other) => 
  //   identical(this, other) || other is SLData
  //      && runtimeType == other.runtimeType
  //      && letter      == other.letter
  //      && data        == other.data
  //      && type        == other.type;

  // @override
  // int get hashCode => 
  //   letter.hashCode ^
  //   data.hashCode ^
  //   type.hashCode;

}



class SLSelections {

  final String selection1;
  final String selection2;

  SLSelections({
    this.selection1,
    this.selection2
  });

  SLSelections copyWith({
    String selection1,
    String selection2
  }) {
    return SLSelections(
      selection1: selection1 ?? this.selection1,
      selection2: selection2 ?? this.selection2
    );
  }

  SLSelections restart() {
    return SLSelections(selection2: null, selection1: null);
  }

  // @override
  // bool operator == (Object other) =>
  //   identical(this, other) || other is SLSelections
  //     && runtimeType == other.runtimeType
  //     && selection1 == other.selection1
  //     && selection2 == other.selection2;
  
  // @override
  // int get hashCode => 
  //   selection1.hashCode ^
  //   selection2.hashCode;

}

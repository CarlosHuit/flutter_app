import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_letter_detail/rc_letter_detail.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class LetterDetailViewModel {
  
  final String       letter;
  final List<String> options;
  final String       typeLetter;
  final bool         showAllCards;
  final bool         hideAllCards;
  final bool         canPlayGame;
  final SLSelections selections;
  final String       selection1;
  final String       selection2;
  final SLData       data;

  final Function(String term) selectOpt;
  final Function() showCards;
  final Function() hideCards;

  LetterDetailViewModel( {
    @required this.letter,
    @required this.options,
    @required this.typeLetter,
    @required this.showAllCards,
    @required this.hideAllCards,
    @required this.canPlayGame,
    @required this.selections,
    @required this.selectOpt,
    @required this.selection1,
    @required this.selection2,
    @required this.showCards,
    @required this.hideCards,
    @required this.data,
  });


  factory LetterDetailViewModel.fromStore(Store<AppState> store) {

  void addSelection(String term, Store<AppState> store) {

    final String firstSelection =store.state.readingCourseState.letterDetail.selections.selection1;

    if (firstSelection == null) {
      print('addFirstSelection');
      store.dispatch(RCAddFirstSelectionLD(term));
    }

    if (firstSelection != null ) {
      print('addSecondSelection');
      store.dispatch(RCAddSecondSelectionLD(term));
    }

  }

    return LetterDetailViewModel(
      letter:       store.state.readingCourseState.letterDetail.currentData.letter,
      options:      store.state.readingCourseState.letterDetail.currentData.data,
      typeLetter:   store.state.readingCourseState.letterDetail.currentData.type,
      showAllCards: store.state.readingCourseState.letterDetail.showAllCards,
      hideAllCards: store.state.readingCourseState.letterDetail.hideAllCards,
      canPlayGame:  store.state.readingCourseState.letterDetail.canPlayGame,
      selections:   store.state.readingCourseState.letterDetail.selections,
      selection1:   store.state.readingCourseState.letterDetail.selections.selection1,
      selection2:   store.state.readingCourseState.letterDetail.selections.selection2,
      data:         store.state.readingCourseState.letterDetail.currentData,
      // selectOpt:    (term) => store.dispatch(RCSelectOptionLD(term)),
      showCards:    () => store.dispatch(RCShowAllCardsLD()),
      hideCards:    () => store.dispatch(RCHideAllCardsLD()),
      selectOpt:    (term) => addSelection(term, store),
    );
  }



  @override
  bool operator == (Object other) => 
  identical(this, other) || other is LetterDetailViewModel
    && runtimeType  == other.runtimeType
    && letter       == other.letter
    && options      == other.options
    && showAllCards == other.showAllCards
    && hideAllCards == other.hideAllCards
    && canPlayGame  == other.canPlayGame
    && selections   == other.selections
    && selection1   == other.selection1
    && selection2   == other.selection2
    && data         == other.data
    && typeLetter   == other.typeLetter;

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
    typeLetter.hashCode;

}
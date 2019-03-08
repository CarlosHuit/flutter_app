class RCShowAllCardsLD {}
class RCHideAllCardsLD {}
class RCSetCurrentDataLD {}
class RCSelectionsAreCorrectsLD {}
class RCSelectionsAreIncorrectsLD {}


class RCSetInitialDataLD {
  final String letter;
  RCSetInitialDataLD(this.letter);
}

class RCAddFirstSelectionLD {
  final String selection;
  RCAddFirstSelectionLD(this.selection);
}

class RCAddSecondSelectionLD {
  final String selection;
  RCAddSecondSelectionLD(this.selection);
}
class RCShowAllCardsLD {}
class RCHideAllCardsLD {}
class RCSelectionsAreCorrectsLD {}
class RCSelectionsAreIncorrectsLD {}

class RCChangeCurrentDataLD {}

class RCSetInitialDataLD {
  final String letter;
  RCSetInitialDataLD(this.letter);
}

class RCResetDataLD { }

class RCAddFirstSelectionLD {
  final String selection;
  RCAddFirstSelectionLD(this.selection);
}

class RCAddSecondSelectionLD {
  final String selection;
  RCAddSecondSelectionLD(this.selection);
}

class RCValidateSelectionsLD {}

class RCHideTryAgainDialogLD {}
class RCHideWellDoneDialogLD {}
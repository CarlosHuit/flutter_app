import 'package:meta/meta.dart';

class RCSetInitialDataG {}
class RCResetDataG {}

class RCRegisterCorrectSelectionG {
  final String letter;
  RCRegisterCorrectSelectionG({@required this.letter});
}

class RCRegisterWrongSelectionG {
  final String letter;
  RCRegisterWrongSelectionG({@required this.letter});
}

class RCHideWellDoneDialogG {}

class RCShowWellDoneDialogG {}
class RCChangeCurrentDataG {}


class RCShowCoincidencesG {}

class RCHideCoincidencesG {}
  
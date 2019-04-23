class RCSetInitialDataPL { }
class RCResetDataPL{}

class RCChangeCurrentDataPL {}

class RCRegisterAttemptPL {}

class RCToggleRecordingStatePL {
  final bool state;
  RCToggleRecordingStatePL(this.state);
}
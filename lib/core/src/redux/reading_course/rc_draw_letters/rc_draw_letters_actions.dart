import 'package:flutter/material.dart';

class RCSetInitialDataDL {}

class RCResetStateDL {}

class RCChangeStrokeSizeDL {
  final double width;
  RCChangeStrokeSizeDL(this.width);
}


class RCChangeStrokeColorDL {
  final Color color;
  RCChangeStrokeColorDL(this.color);
}


class RCToggleGuideLines {}

class RCToggleStrokeSizeSelectorDL {}

class RCToggleStrokeColorSelectorDL {}
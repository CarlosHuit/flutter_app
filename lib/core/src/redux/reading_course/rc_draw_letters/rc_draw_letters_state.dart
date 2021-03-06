import 'package:app19022019/core/src/redux/reading_course/reading_course_state.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class RCDrawLettersState {

  final List<RCDrawLetterData> data;
  final RCDrawLetterData currrentData;
  final bool isSettingData;
  final bool showWellDoneDialog;
  final RCDrawLetterPreferences preferences;
  final RCDrawLetterConfigData configData;
  final int currentIndex;
  final bool showHandWriting;
  final RCDrawLettersTopControlBar topControlBar;

  RCDrawLettersState({
    @required this.data,
    @required this.currrentData,
    @required this.isSettingData,
    @required this.showWellDoneDialog,
    @required this.preferences,
    @required this.configData,
    @required this.currentIndex,
    @required this.showHandWriting,
    @required this.topControlBar
  });

  factory RCDrawLettersState.fromStateData(ReadingCourseState state) {

    final pathData = state.data;

    final letter      = pathData.currentLetter.toLowerCase();
    final letterSound = pathData.soundLetters[letter];

    final letterUpperCase = letter.toUpperCase();
    final letterLowerCase = letter.toLowerCase();

    final cooLowerCase = pathData.coordinates.firstWhere((i) => i.letter == letterLowerCase ).coordinates;
    final cooUpperCase = pathData.coordinates.firstWhere((i) => i.letter ==letterUpperCase ).coordinates;

    final List<List<Offset>> offsetLowerCaselist = [];

    cooLowerCase.forEach((g) {

      List<Offset> tempOffsets = [];
      g.forEach((c) => tempOffsets.add(  Offset( c.x.toDouble(), c.y.toDouble() )  ));
      offsetLowerCaselist.add(tempOffsets);

    });


    final List<List<Offset>> offsetUpperCaseList = [];

    cooUpperCase.forEach((g) {

      List<Offset> tempOffsets = [];
      g.forEach((c) => tempOffsets.add(  Offset( c.x.toDouble(), c.y.toDouble() )  ));
      offsetUpperCaseList.add(tempOffsets);

    });

    final dataLowerCase = RCDrawLetterData(
      coordinates: offsetLowerCaselist,
      letter: letterLowerCase,
      soundLetter: letterSound,
      type: 'minúscula' 
    );

    final dataUpperCase =RCDrawLetterData(
      coordinates: offsetUpperCaseList,
      letter: letterUpperCase,
      soundLetter: letterSound,
      type: 'mayúscula'
    );

    final coordinatesData = [ dataLowerCase, dataUpperCase ];

    final configData =RCDrawLetterConfigData(
      width: 12.0,
      maxLineWidth: 18.0,
      minLineWidth: 6.0,
      step: 12,
      colors: [
        Colors.red,
        Colors.blue,
        Colors.deepOrange,
        Colors.pink,
        Colors.yellow,
        Colors.green,
        Colors.orange,
        Colors.purple,
        Colors.indigo,
        Colors.black
      ]
    );

    final userPreferences = RCDrawLetterPreferences(
      lineWidth: 10.0,
      lineColor: Colors.blue,
      styleLine: StrokeCap.round,
      showGuideLines: true,
    );

    final topControlBar = RCDrawLettersTopControlBar(
      showStrokeColorSelector: false,
      showStrokeSizeSelector: false,
    );

    return RCDrawLettersState(
      data:               coordinatesData,
      configData:         configData,
      preferences:        userPreferences,
      currentIndex:       0,
      currrentData:       coordinatesData[0],
      isSettingData:      false,
      showHandWriting:    true,
      showWellDoneDialog: false,
      topControlBar:      topControlBar,
    );
  }

  factory RCDrawLettersState.initialState() {
    return RCDrawLettersState(
      configData: null,
      currentIndex: null,
      currrentData: null,
      data: null,
      isSettingData: null,
      preferences: null,
      showHandWriting: null,
      showWellDoneDialog: null,
      topControlBar: null,
    );
  }

  RCDrawLettersState copyWith({
    List<RCDrawLetterData> data,
    RCDrawLetterData currrentData,
    bool isSettingData,
    bool showWellDoneDialog,
    RCDrawLetterPreferences preferences,
    RCDrawLetterConfigData configData,
    int currentIndex,
    bool showHandWriting,
    RCDrawLettersTopControlBar topControlBar,
  }) {

    return RCDrawLettersState(
      data: data ?? this.data,
      currrentData: currrentData ?? this.currrentData,
      isSettingData: isSettingData ?? this.isSettingData,
      showWellDoneDialog: showWellDoneDialog ?? this.showWellDoneDialog,
      preferences: preferences ?? this.preferences,
      configData: configData ?? this.configData,
      currentIndex: currentIndex ?? this.currentIndex,
      showHandWriting: showHandWriting ?? this.showHandWriting,
      topControlBar: topControlBar ?? this.topControlBar,
    );

  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) || other is RCDrawLettersState
      && runtimeType        == other.runtimeType
      && data               == other.data
      && currrentData       == other.currrentData
      && isSettingData      == other.isSettingData
      && showWellDoneDialog == other.showWellDoneDialog
      && preferences        == other.preferences
      && configData         == other.configData
      && currentIndex       == other.currentIndex
      && showHandWriting    == other.showHandWriting
      && topControlBar      == other.topControlBar;

  @override
  int get hashCode =>
    data.hashCode ^
    currrentData.hashCode ^
    isSettingData.hashCode ^
    showWellDoneDialog.hashCode ^
    preferences.hashCode ^
    configData.hashCode ^
    currentIndex.hashCode ^
    showHandWriting.hashCode ^
    topControlBar.hashCode;

}


class RCDrawLetterData {

  final List<List<Offset>> coordinates;
  final String letter;
  final String type;
  final String soundLetter;

  RCDrawLetterData({
    @required this.coordinates,
    @required this.letter,
    @required this.type,
    @required this.soundLetter
  });

}


class RCDrawLetterPreferences {

  final double lineWidth;
  final MaterialColor lineColor; 
  final bool showGuideLines;
  final StrokeCap styleLine;

  RCDrawLetterPreferences({
    @required this.lineWidth,
    @required this.lineColor,
    @required this.showGuideLines,
    @required this.styleLine
  });

  RCDrawLetterPreferences copyWith({
    double lineWidth,
    MaterialColor lineColor,
    bool showGuideLines,
    StrokeCap styleLine,
  }) {

    return RCDrawLetterPreferences(
      lineWidth: lineWidth ?? this.lineWidth,
      lineColor: lineColor ?? this.lineColor,
      showGuideLines: showGuideLines ?? this.showGuideLines,
      styleLine: styleLine ?? this.styleLine,
    );

  }

}

class RCDrawLetterConfigData {

  final List<Color> colors;
  final double maxLineWidth;
  final double minLineWidth;
  final double width;
  final int step;

  RCDrawLetterConfigData({
    @required this.colors,
    @required this.maxLineWidth,
    @required this.minLineWidth,
    @required this.width,
    @required this.step
  });

}

class RCDrawLettersTopControlBar {

  final bool showStrokeSizeSelector;
  final bool showStrokeColorSelector;

  RCDrawLettersTopControlBar({
    @required this.showStrokeSizeSelector,
    @required this.showStrokeColorSelector
  });

  RCDrawLettersTopControlBar copyWith({
    bool showStrokeSizeSelector,
    bool showStrokeColorSelector
  }) {

    return RCDrawLettersTopControlBar(
      showStrokeColorSelector: showStrokeColorSelector ?? this.showStrokeColorSelector,
      showStrokeSizeSelector: showStrokeSizeSelector ?? this.showStrokeSizeSelector,
    );

  }
}


class StrokeData {

  final MaterialColor color;
  final double width;
  final List<Offset> points;

  StrokeData(this.color, this.width, this.points);

}




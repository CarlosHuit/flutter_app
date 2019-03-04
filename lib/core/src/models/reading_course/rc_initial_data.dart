import 'package:app19022019/core/src/redux/reading_course/rc_data/rc_data_state.dart';
import 'package:meta/meta.dart';

class RCInitialData {

  final List<Words>          words;
  final Letters              letters;
  final List<LearnedLetter>  learnedLetters;
  final List<SimilarLetters> similarLetters;
  final List<Coordinates>    coordinates;

  RCInitialData({
    @required this.words,
    @required this.letters,
    @required this.learnedLetters,
    @required this.similarLetters,
    @required this.coordinates
  });

  factory RCInitialData.fromJson(dynamic json) {

    final Letters letters = Letters.fromJson(json['letters']);

    List<Words> tempWords = [];
    List.from(json['words']).forEach( (el) =>
      tempWords.add(Words.fromJson(el)) );


    List<SimilarLetters> tempSL = [];
    List.from(json['similarLetters']).forEach((el) =>
      tempSL.add(SimilarLetters.fromJson(el)));


    List<LearnedLetter> tempLL = [];
    List.from(json['learnedLetters']).forEach((el) =>
      tempLL.add(LearnedLetter.fromJson( el, letters.combinations[el['letter']] )));


    List<Coordinates> tempCoordinates = [];
    List.from(json['coordinates']).forEach((el) =>
      tempCoordinates.add(Coordinates.fromJson(el)));


    return RCInitialData(
      words:          tempWords,
      letters:        letters,
      coordinates:    tempCoordinates,
      learnedLetters: tempLL,
      similarLetters: tempSL,
    );


  }

  Map<String, dynamic> toJson() {

    List<dynamic> listOfWords = [];
    List<dynamic> listOfLearnedLetters = [];
    List<dynamic> listOfCoordinates    = [];
    List<dynamic> listOfSimilarLetters = [];

    this.words.forEach((f) => listOfWords.add(f.toJson()));
    this.learnedLetters.forEach((f) => listOfLearnedLetters.add(f.toJson()));
    this.coordinates.forEach((f) => listOfCoordinates.add(f.toJson()));
    this.similarLetters.forEach((f) => f.toJson());

    return {
      'letters':        this.letters.toJson(),
      'words':          listOfWords,
      'learnedLetters': listOfLearnedLetters,
      'coordinates':    listOfCoordinates,
      'similarLetters': listOfSimilarLetters

    };


  }

}

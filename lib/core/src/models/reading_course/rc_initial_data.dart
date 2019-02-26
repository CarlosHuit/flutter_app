import 'package:app19022019/core/src/models/reading_course/rc_data_model.dart';
import 'package:meta/meta.dart';

class RCInitialData {

  final List<Words>          words;
  final Letters              letters;
  final List<LearnedLetter>  learnedLetters;
  final List<SimilarLetters> similarLetters;
  final List<Coordinates>     coordinates;

  RCInitialData({
    @required this.words,
    @required this.letters,
    @required this.learnedLetters,
    @required this.similarLetters,
    @required this.coordinates
  });

  factory RCInitialData.fromJson(Map<String, dynamic> parsedJson) {


    Letters letters = Letters(
      parsedJson['alphabet'],
      parsedJson['consonants'],
      parsedJson['vocals'],
      parsedJson['combinations'],
      parsedJson['sound_letters']
    );



    List<Words> tempWords = [];

    for (var i = 0; i < parsedJson['words'].length; i++) {

      final Words el = Words.fromJson(parsedJson['words'][i]);
      tempWords.add(el);

    }



    List<SimilarLetters> tempSL = [];

    for (var i = 0; i < parsedJson['similarLetters'].length; i++) {

      final SimilarLetters el = SimilarLetters.fromJson(parsedJson['similarLetters'][i]);
      tempSL.add(el);

    }



    List<LearnedLetter> tempLL = [];

    for (var i = 0; i < parsedJson['learnedLetters'].length; i++) {

      final Map<String, dynamic> el = parsedJson['learnedLetters'][i];
      final List<Combination> combinations = letters.combinations[el['letter']];
      final LearnedLetter elLearnedLetter  = LearnedLetter.fromJson( el, combinations );

      tempLL.add(elLearnedLetter);

    }



    List<Coordinates> tempCoordinates = [];

    for (var i = 0; i < parsedJson['coordinates'].length; i++) {
      final Coordinates coordinates = Coordinates.fromJson( parsedJson['coordinates'][i] );
      tempCoordinates.add(coordinates);
    }


    return RCInitialData(
      words:          tempWords,
      letters:        letters,
      coordinates:    tempCoordinates,
      learnedLetters: tempLL,
      similarLetters: tempSL,
    );


  }

}

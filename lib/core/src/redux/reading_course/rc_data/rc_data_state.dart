import 'package:app19022019/core/src/models/reading_course/rc_initial_data.dart';
import 'package:meta/meta.dart';

@immutable
class RCDataState {

  final String currentLetter;
  final String alphabet;
  final String consonants;
  final String vocals;
  final bool   isLoading;

  final Map<String, List<Combination>> combinations;
  final List<Words>          words;
  final List<Coordinates>    coordinates;
  final List<LearnedLetter>  learnedLetters;
  final List<ItemLetterMenu> lettersMenu;
  final List<SimilarLetters> similarLetters;
  final Map<String, dynamic> soundLetters;

  RCDataState({
    @required this.words,
    @required this.alphabet,
    @required this.consonants,
    @required this.vocals,
    @required this.learnedLetters,
    @required this.lettersMenu,
    @required this.combinations,
    @required this.soundLetters,
    @required this.similarLetters,
    @required this.coordinates,
    @required this.currentLetter,
    @required this.isLoading,
  });

  factory RCDataState.initialData() {
    return RCDataState(
      words:          null,
      vocals:         null,
      alphabet:       null,
      consonants:     null,
      coordinates:    null,
      lettersMenu:    null,
      combinations:   null,
      soundLetters:   null,
      currentLetter:  null,
      learnedLetters: null,
      similarLetters: null,
      isLoading:      null,
    );
  }

  factory RCDataState.fromData(RCInitialData data) {

    final List<ItemLetterMenu> itemsLettersMenu = [];

    data.words.forEach((word) {

      final bool letterNoLearned = data.learnedLetters.indexWhere((l) => l.letter == word.l ) < 0;

      if ( letterNoLearned ) {
        itemsLettersMenu.add(
          ItemLetterMenu(word.l, word.l.toUpperCase(), word.l, word.w[0], 'assets/img100X100/${word.w[0]}-min.png' ));
      }

    });

    return RCDataState(
      currentLetter:  null,
      alphabet:       data.letters.alphabet,
      consonants:     data.letters.consonants,
      vocals:         data.letters.vocals,
      combinations:   data.letters.combinations,
      words:          data.words,
      soundLetters:   data.letters.soundLetters,
      learnedLetters: data.learnedLetters,
      coordinates:    data.coordinates,
      similarLetters: data.similarLetters,
      lettersMenu:    itemsLettersMenu,
      isLoading:      false
    );

  }

  RCDataState copyWith({
    String               vocals,
    String               alphabet,
    bool                 isLoading,
    String               consonants,
    String               currentLetter,
    List<Words>          words,
    List<Coordinates>    coordinates,
    List<LearnedLetter>  learnedLetters,
    List<ItemLetterMenu> lettersMenu,
    List<SimilarLetters> similarLetters,
    Map<String, dynamic> soundLetters,
    Map<String, List<Combination>> combinations,
  }) {

    return RCDataState(
      words:          words ?? this.words,
      vocals:         vocals ?? this.vocals,
      alphabet:       alphabet ?? this.alphabet,
      isLoading:      isLoading ?? this.isLoading,
      consonants:     consonants ?? this.consonants,
      lettersMenu:    lettersMenu ?? this.lettersMenu,
      coordinates:    coordinates ?? this.coordinates,
      combinations:   combinations ?? this.combinations,
      soundLetters:   soundLetters ?? this.soundLetters,
      currentLetter:  currentLetter ?? this.currentLetter,
      learnedLetters: learnedLetters ?? this.learnedLetters,
      similarLetters: similarLetters ?? this.similarLetters,
    );

  }

  @override
  bool operator == (Object other) =>
    identical(this, other) || other is RCDataState
      && runtimeType    == other.runtimeType
      && words          == other.words
      && alphabet       == other.alphabet
      && consonants     == other.consonants
      && vocals         == other.vocals
      && learnedLetters == other.learnedLetters
      && lettersMenu    == other.lettersMenu
      && combinations   == other.combinations
      && soundLetters   == other.soundLetters
      && similarLetters == other.similarLetters
      && coordinates    == other.coordinates
      && currentLetter  == other.currentLetter
      && isLoading      == other.isLoading;

  @override
  int get hashCode => 
    words.hashCode ^
    alphabet.hashCode ^
    consonants.hashCode ^
    vocals.hashCode ^
    learnedLetters.hashCode ^
    lettersMenu.hashCode ^
    combinations.hashCode ^
    soundLetters.hashCode ^
    similarLetters.hashCode ^
    coordinates.hashCode ^
    currentLetter.hashCode ^
    isLoading.hashCode;

}



class Coordinates {

  final List<List<Coordinate>> coordinates;
  final String letter;

  Coordinates(this.coordinates, this.letter);

  factory Coordinates.fromJson(Map<String, dynamic> parsedJson) {

    final List<List<Coordinate>> groupOfCoordinates = [];

    for (var i = 0; i < parsedJson['coordinates'].length; i++) {

      final List<dynamic> el = parsedJson['coordinates'][i];
      final List<Coordinate> tempListCoo = [];
      el.forEach((e) => tempListCoo.add( Coordinate(e['x'], e['y']) ));

      groupOfCoordinates.add(tempListCoo);

    }

    return Coordinates(groupOfCoordinates, parsedJson['letter']);

  }


  Map<String, dynamic> toJson() {

    final List<dynamic> groupCoordinatesList = [];

    this.coordinates.forEach((x) {
      final List<dynamic> coordinatesList = [];
      x.forEach((f) => coordinatesList.add(f.toJson()));
      groupCoordinatesList.add(coordinatesList); 
    });

    return {
      'letter':      letter,
      'coordinates': groupCoordinatesList
    };

  }


}



class Coordinate {

  final int x;
  final int y;

  Coordinate(this.x, this.y);

  Map<String, dynamic> toJson() => { 'x': x, 'y': y };


}



class SimilarLetters {

  final String l;
  final List<String> sl;

  SimilarLetters(this.l, this.sl);

  factory SimilarLetters.fromJson(Map<String, dynamic> parsedJson) {

    final List<String> similarLettersList = [];
    List.from(parsedJson['sl']).forEach((letter) => similarLettersList.add(letter) );
    return SimilarLetters(parsedJson['l'], similarLettersList);

  }

  Map<String, dynamic> toJson() {

    final List<dynamic> listOfSimilarLetters = [];
    this.sl.forEach((sl) => listOfSimilarLetters.add(sl));

    return {
      'l':  l,
      'sl': listOfSimilarLetters
    };
  }

}



class ItemLetterMenu {

  final String letterLowerCase;
  final String letterUpperCase;
  final String letter;
  final String word;
  final String imgUrl;

  ItemLetterMenu(this.letterLowerCase, this.letterUpperCase, this.letter, this.word, this.imgUrl);

  Map<String, dynamic> toJson() {

    return {
      'letterLowerCase': letterLowerCase,
      'letterUpperCase': letterUpperCase,
      'letter':          letter,
      'word':            word,
      'imgUrl':          imgUrl,
    };

  }

}



class Words {

  final String       l;
  final List<String> w;

  Words(this.l, this.w);

  factory Words.fromJson(Map<String, dynamic> parsedJson) {

    final List<String> wordsList = [];
    List.from(parsedJson['w']).forEach((word) => wordsList.add(word) );
    return Words( parsedJson['l'], wordsList );

  }

  Map<String, dynamic> toJson() {

    final List<String> s = [];
    this.w.forEach((w) => s.add(w));
    return { 'l': l, 'w': s };

  }

}



class Letters {
  final String  alphabet;
  final String  consonants;
  final String  vocals;
  final Map<String, List<Combination>> combinations;
  final Map<String, dynamic> soundLetters;

  Letters(this.alphabet, this.consonants, this.vocals, this.combinations, this.soundLetters);

  factory Letters.fromJson(Map<String, dynamic> parsedJson) {

    final String alphabet   = parsedJson['alphabet'];
    final String consonants = parsedJson['consonants'];
    final String vocals     = parsedJson['vocals'];
    final Map<String, List<Combination>> combinations = {};
    final Map<String, dynamic> soundLetters = parsedJson['sound_letters'];

    Map.from(parsedJson['combinations']).forEach((key, el) {

      final List<Combination> listOfCombinations = [];
      List.from(el).forEach((c) => listOfCombinations.add(Combination(c['p'], c['w']) ));
      combinations[key.toString()] = listOfCombinations;

    });

    return Letters(alphabet, consonants, vocals, combinations, soundLetters);

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> combinationsJson = {};

    this.combinations.forEach((key, value) {
      final List<dynamic> listOfCombinations = [];
      value.forEach((c) => listOfCombinations.add(c.toJson()));
      combinationsJson[key.toString()] = listOfCombinations;
    });

    return {
      'vocals':       vocals,
      'alphabet':     alphabet,
      'consonants':   consonants,
      'soundLetters': soundLetters,
      'combinations': combinationsJson,
    };

  }

}



class LearnedLetter {

  final String letter;
  final int rating;
  final List<Combination> combinations;

  LearnedLetter(this.letter, this.rating, this.combinations);

  factory LearnedLetter.fromJson(Map<String, dynamic> parsedJson, List<Combination> combinations) {

    return LearnedLetter(
      parsedJson['letter'],
      parsedJson['rating'],
      combinations
    );

  }

  Map<String, dynamic> toJson() {

    List<dynamic> combinationList = [];

    combinations.forEach((combination) => combinationList.add(combination.toJson()));

    return {
      'letter': letter,
      'rating': rating,
      'combinations': combinationList
    };

  }

}



class Combination {

  final String p;
  final String w;
  Combination(this.p, this.w);

  Map<String, dynamic> toJson() {
    return {
      'p': p,
      'w': w
    };
  }

}

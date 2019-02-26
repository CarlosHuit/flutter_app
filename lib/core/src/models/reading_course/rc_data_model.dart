class ReadingCourseDataModel {
  final bool                  isLoadingData;
  final String                currentLetter;
  final Letters               letters;
  final dynamic               combinations;
  final List<Words>           words;
  final List<Coordinates>     coordinates;
  final List<LearnedLetter>   learnedLetters;
  final List<ItemLetterMenu>  lettersMenu;
  final List<SimilarLetters>  similarLetters;
  final Map<String, dynamic>  letterSounds;

  ReadingCourseDataModel({
    this.words,
    this.letters,
    this.learnedLetters,
    this.isLoadingData,
    this.lettersMenu,
    this.combinations,
    this.letterSounds,
    this.similarLetters,
    this.coordinates,
    this.currentLetter
  });

}


class Coordinates {

  final List<Coordinate> coordinates;
  final String letter;

  Coordinates(this.coordinates, this.letter);

  factory Coordinates.fromJson(Map<String, dynamic> parsedJson) {
    final List<Coordinate> tempCoordinates = [];

    for (var i = 0; i < parsedJson['coordinates'].length; i++) {
      final Map<String, int> el = parsedJson['coordinates'][i];
      tempCoordinates.add(Coordinate(el['x'], el['y']));     
    }

    return Coordinates(tempCoordinates, parsedJson['letter']);

  }

}

class Coordinate {

  final int x;
  final int y;

  Coordinate(this.x, this.y);

}

class SimilarLetters {
  final String       l;
  final List<String> sl;

  SimilarLetters(this.l, this.sl);

  factory SimilarLetters.fromJson(Map<String, dynamic> parsedJson) {
    return SimilarLetters(parsedJson['l'], parsedJson['sl']);
  }
}

class ItemLetterMenu {

    final String letterLowerCase;
    final String letterUpperCase;
    final String letter;
    final String word;
    final String imgUrl;

  ItemLetterMenu(this.letterLowerCase, this.letterUpperCase, this.letter, this.word, this.imgUrl);

}

class Words {

  final String       l;
  final List<String> w;

  Words(this.l, this.w);

  factory Words.fromJson(Map<String, dynamic> parsedJson) {
    return Words( parsedJson['l'], parsedJson['w'] );
  }

}


class Letters {
  final String  alphabet;
  final String  consonants;
  final String  vocals;
  final dynamic combinations;
  final Map<String, dynamic> soundLetters;

  Letters(this.alphabet, this.consonants, this.vocals, this.combinations, this.soundLetters);
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

}

class Combination {
  final String p;
  final String w;

  Combination(this.p, this.w);
}
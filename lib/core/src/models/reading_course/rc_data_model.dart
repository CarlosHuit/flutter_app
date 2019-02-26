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

  final List<Coordinate> coorindates;
  final String letter;

  Coordinates(this.coorindates, this.letter);

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

}


class Letters {
  final String  alphabet;
  final String  consonants;
  final String  vocals;
  final dynamic combinatios;
  final Map<String, dynamic> sount_letters;

  Letters(this.alphabet, this.consonants, this.vocals, this.combinatios, this.sount_letters);
}


class LearnedLetter {
  final String letter;
  final int rating;
  final List<Combination> combinations;

  LearnedLetter(this.letter, this.rating, this.combinations);
}

class Combination {
  final String p;
  final String w;

  Combination(this.p, this.w);
}
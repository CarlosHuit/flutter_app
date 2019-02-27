import 'package:flutter_tts/flutter_tts.dart';
import 'package:meta/meta.dart';

class SpeechSynthesisService {

  FlutterTts _flutterTts = FlutterTts();

/// [Future] method to speech a term and return a FlutterTts to add event listeners
  Future<FlutterTts> speak({@required String term, String lang, int rate, int volume, int pitch }) async {

    final String language    = lang ?? 'es-US';
    final double speechRate  = rate ?? 1.0;
    final double speechVol   = volume ?? 1.0;
    final double speechPitch = pitch ?? 1.0;

    await _flutterTts.setLanguage(language);
    await _flutterTts.setSpeechRate(speechRate);
    await _flutterTts.setVolume(speechVol);
    await _flutterTts.setPitch(speechPitch);


    final int result = await _flutterTts.speak(term);


    return _flutterTts;

  }


}



// await _flutterTts.isLanguageAvailable("en-US");
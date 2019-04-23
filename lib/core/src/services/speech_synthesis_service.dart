import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

class SpeechSynthesisService {

  static final Function() stop = () => FlutterTts().stop();

  FlutterTts _flutterTts = FlutterTts();

/// [Future] method to speech a term and return a FlutterTts to add event listeners
  Future<FlutterTts> speak(String term, {
    // @required String term,
    String lang,
    double rate,
    double volume,
    double pitch
  }) async {

    final String language    = lang   ?? 'es-US';
    final double speechRate  = rate   ?? 1.0;
    final double speechVol   = volume ?? 1.0;
    final double speechPitch = pitch  ?? 1.0;

    await _flutterTts.setLanguage(language);
    await _flutterTts.setSpeechRate(speechRate);
    await _flutterTts.setVolume(speechVol);
    await _flutterTts.setPitch(speechPitch);


    await _flutterTts.speak(term);

    return _flutterTts;

  }

  void cancel() {
    _flutterTts.stop();
  }


}

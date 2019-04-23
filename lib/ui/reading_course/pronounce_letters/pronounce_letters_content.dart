import 'dart:io';

import 'package:app19022019/core/src/viewmodels/reading_course/pronounce_letters_view_model.dart';
import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';


class PronounceLettersContent extends StatefulWidget {

  final PronounceLettersViewModel vm;

  const PronounceLettersContent({
    Key key,
    @required this.vm
  }) : super(key: key);

  @override
  _PronounceLettersContentState createState() => _PronounceLettersContentState();
}


class _PronounceLettersContentState extends State<PronounceLettersContent> {


  PronounceLettersViewModel get vm => widget.vm;
  SpeechRecognition speechRecognition;
  List<Language> languages;
  Language    language;
  String   transcription;
  bool   isRecording;
  bool recognitionAvailable;


  @override
  void initState() {
    super.initState();

    languages = [
      Language('Español', 'es_US'),
      Language('Español', 'es_ES'),
      Language('English', 'en_US'),
    ];

    language = languages[0];
    isRecording = false;
    transcription = '';
    recognitionAvailable = false;

    activateSpeechRecognition();
    vm.speakInstructions();

  }


  void activateSpeechRecognition() {

    speechRecognition = SpeechRecognition();
    speechRecognition.setAvailabilityHandler(onSpeechAvailability);
    speechRecognition.setCurrentLocaleHandler(onCurrentLocale);
    speechRecognition.setRecognitionStartedHandler(onRecognitionStart);
    speechRecognition.setRecognitionResultHandler(onRecognitionResult);
    speechRecognition.setRecognitionCompleteHandler(onRecognitionComplete);
    speechRecognition.setRecognitionErrorHandler(onRecognitionError);

    speechRecognition
      .activate()
      .then((res) {

        setState(() {
          recognitionAvailable = res;
        });

      });

  }


  void onRecognitionError(dynamic s) {

    setState(() {
      isRecording = false;
    });

    final androidErrorCodes = {
      1: 'ERROR_NETWORK_ERROR',
      2: 'ERROR_NETWORK',
      3: 'ERROR_AUDIO',
      4: 'ERROR_SERVER',
      5: 'ERROR_CLIENT',
      6: 'ERROR_SPEECH_TIMEOUT',
      7: 'ERROR_NO_MATCH',
      8: 'ERROR_RECOGNIZER_BUSY',
      9: 'ERROR_INSUFICIENT_PERMISSIONS'
    };

    final code = s != null ? int.parse('$s') : null;
    
    // If platform is Android handle SpeechRecognizer error 
    if (Theme.of(context).platform == TargetPlatform.android) {

      print(androidErrorCodes[code]);

      if (code == 7 || code == 6) {
        vm.speakMessageWrongRecogntion();
      }

    }

    // If platform is IOS handle Speech API error
    if (Theme.of(context).platform == TargetPlatform.android) {
      vm.speakMessageWrongRecogntion();
    }


  }


  void onSpeechAvailability(bool result) {
    setState(() {
      recognitionAvailable = result;
    });
  }


  void onCurrentLocale(String locale) {

    setState(() {
      language = languages.firstWhere(
        (lang) => lang.code == locale
      );
    });

  }


  void onRecognitionStart() {

    setState(() {
      isRecording = true;
    });

  }


  void onRecognitionResult(String txt) {

    print('result is......: $txt');
    setState(() {
      transcription = txt;
    });

  }


  void onRecognitionComplete() {

    print('123456789012345678901234567890123456789012345678901234567890..........: $transcription');

    if (transcription.trim().length > 0) {

      // if (transcription == vm.pronunciation) {
      if (transcription.contains(vm.pronunciation)) {

        vm.speakWellDone();

      } else {

        vm.speakMessageTryAgain();

      }

    }

    setState(() => isRecording = false );

  }


  void startRecognition() {

    vm.stopTts();

    setState(() => isRecording = true );

    speechRecognition
      .listen(locale: language.code)
      .then((result) => print('Recognition: $result') ); 

  }


  void cancelRecognition() {

    speechRecognition
      .cancel()
      .then((result) {
        setState(() {
          isRecording = result;
        });
      });

  }


  void stopRecognition() {

    speechRecognition
      .stop()
      .then((result) {
        setState(() {
          isRecording = result;
        });
      });

  }


  String generateUrl(String name) => 'assets/flare/$name.flr';


  @override
  Widget build(BuildContext context) {

    final s = Theme.of(context).platform;
    print('platfotm: $s - ${Platform.isAndroid}');

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          buildLetter(vm.currentData.letter),
          buildButtonRecord(),
        ],
      ),
    );

  }


  Widget buildLetter(String letter) {

    return Container(

      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          color:  Colors.red,
          fontSize: 160.0,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(-1, 4)
            )
          ]
        ),
      ),

    );

  }


  Widget buildButtonRecord() {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.topRight,
              child: CustomCircularIconButton(
                icon: Icon(
                  Icons.help_outline,
                  color: Colors.orange[400],
                  size: 42.0,
                ),
                onTap: vm.speakHelp,
                height: 56.0,
                width: 56.0,
                splashColor: Colors.orange[50],
              ),
            ),
          ),

          isRecording
            ? Container(
              height: 45.0,
              child:  FlareActor(
                generateUrl('recording'),
                fit: BoxFit.fitHeight,
                color: Colors.orange[300],
                animation: 'record',
              ),
            )
            : Container(
              height: 45.0,
              child: FlareActor(
                generateUrl('points'),
                fit: BoxFit.fitHeight,
                color: Colors.orange[300],
              ),
            ),

          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only( bottom: 20.0, top: 10.0 ),
            child: CustomCircularIconButton(
              onTap: isRecording ? null : startRecognition,
              color: Theme.of(context).primaryColor,
              width:  68.0,
              height: 68.0,
              elevation: 3.0,
              splashColor: Colors.white12,
              icon: Icon(
                isRecording ? Icons.hearing : Icons.mic,
                color: Colors.white,
                size:  34.0,
              ),
            )

          )


        ],
      ),
    );



  }


}


class Language {

  final String name;
  final String code;

  Language(this.name, this.code);

}

import 'package:app19022019/core/src/viewmodels/reading_course/pronounce_letters_view_model.dart';
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

    speechRecognition
      .activate()
      .then((res) {

        print(res);
        setState(() {
          recognitionAvailable = res;
        });

      });

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
    print('result is......: txt');
    setState(() {
      transcription = txt;
    });
  }


  void onRecognitionComplete() {
    setState(() {
      isRecording = false;
    });
  }


  void startRecognition() {

    setState(() {
      isRecording = true;
    });

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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[

          Positioned( top: 10, child: Text(transcription) ),
          buildLetter(vm.currentData.letter),
          buildButtonRecord()

        ],
      )
    );

  }


  Widget buildLetter(String letter) {

    return Container(
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          fontSize: 160.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor
        ),
      ),
    );

  }


  Widget buildButtonRecord() {

    return Container(
      padding: EdgeInsets.only(bottom: 30.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment:   MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Text( isRecording
            ? 'Grabando.!!'
            : ''
          ),


          InkWell(
            onTap: !isRecording ? startRecognition : null,
            child: Container(
              width:  60.0,
              height: 60.0,
              decoration: BoxDecoration(

                color:        Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(50.0)

              ),
              child: Icon(
                Icons.mic,
                size: 36.0,
                color: Colors.white,
              )
            ),
          ),

        ],
      )
    );

  }


}


class Language {

  final String name;
  final String code;

  Language(this.name, this.code);

}


import 'package:app19022019/core/src/viewmodels/reading_course/pronounce_letters_view_model.dart';
import 'package:app19022019/ui/components/custom_icon_button.dart';
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

    speechRecognition
      .activate()
      .then((res) {

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
        fit: StackFit.expand,
        children: <Widget>[
          buildLetter(vm.currentData.letter),
          buildButtonRecord(),
        ],
      ),
    );

  }

/* 
            Container(
              // color: Colors.green,
              height: 140.0,
              child: Column(
                children: <Widget>[
                  Container(
                    child: RecordingAnimation(),
                  ),
                  Container(
                    width: 60.0,
                    height: 60.0,
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(100.0)
                    ),
                    child: Icon(
                      Icons.mic,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )


 */

  Widget buildLetter(String letter) {

    return Container(
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          color:      Theme.of(context).primaryColor,
          fontSize:   160.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

  }


  Widget buildButtonRecord() {

    final Size _size = Size( 80.0, 80.0 );
    final BorderRadius _radius = BorderRadius.circular(100.0);
    final MaterialColor _color = Theme.of(context).primaryColor;

    final _decoration = BoxDecoration(
      borderRadius: _radius,
      color: _color,
      boxShadow: [
        BoxShadow(
          blurRadius: 5.0, color: Colors.black54, offset: Offset(0, 1.5)
        )
      ]
    );

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

          CustomIconButton(
            onTap:  () => print('pressed'),
            height: 68.0,
            width:  68.0,
            color:  _color,
            elevation:   3.0,
            splashColor: Colors.white12,
            icon: Icon(
              Icons.mic,
              color: Colors.white,
              size: 34.0,
            ),
          )

        ],
      ),
    );

    // return Container(


    //   padding:   EdgeInsets.only(bottom: 30.0),
    //   alignment: Alignment.center,
    //   child: Column(
    //     mainAxisAlignment:  MainAxisAlignment.end,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[

    //       Container(

    //         width:      _size.width,
    //         height:     _size.height,
    //         decoration: _decoration,

    //         child: Stack(
    //           fit: StackFit.expand,
    //           children: <Widget>[

    //             Material(
    //               borderRadius: _radius,
    //               color: Colors.transparent,
    //               child: InkWell(
    //                 borderRadius:  _radius,
    //                 splashFactory: InkRipple.splashFactory,
    //                 onTap: () => print('Hola Mundo!') ,
    //                 child: Container(

    //                   child: Icon(
    //                     Icons.mic,
    //                     color: Colors.white,
    //                     size: _size.height * .50
    //                   ),

    //                 ),
    //               ),
    //             )

    //           ],
    //         ),

    //       )
          
    //     ],
    //   ),


    // );


  }


}


class Language {

  final String name;
  final String code;

  Language(this.name, this.code);

}


class RecordingAnimation extends StatefulWidget {
  @override
  _RecordingAnimationState createState() => _RecordingAnimationState();
}

class _RecordingAnimationState extends State<RecordingAnimation> {
  @override
  Widget build(BuildContext context) {
    print('animating');
    return Container(
      height: 50,
      child: FlareActor(
        'assets/flare/recording.flr',
        fit:        BoxFit.fitHeight,
        animation: 'record',
        color:     Colors.orange[300],
      ),
    );
  }
}
import 'package:app19022019/core/src/viewmodels/reading_course/pronounce_letters_view_model.dart';
import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:app19022019/ui/components/well_done_dialog_app.dart';
import 'package:app19022019/utils/my_behavior.dart';
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

  PageController _pageController;

  PronounceLettersViewModel get vm => widget.vm;
  SpeechRecognition speechRecognition;
  List<Language> languages;
  Language    language;
  bool recognitionAvailable;

  bool popScopeInProgress;


  @override
  void initState() {

    super.initState();

    popScopeInProgress = false;
    _pageController = PageController();

    languages = [
      Language('Español', 'es_US'),
      Language('Español', 'es_ES'),
      Language('English', 'en_US'),
    ];

    language = languages[0];
    recognitionAvailable = false;

    activateSpeechRecognition();
    vm.speakInstructions();

  }

  @override
  void dispose() {

    _pageController.dispose();
    super.dispose();

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

        setState(() => recognitionAvailable = res );

      });

  }


  /// [ void ] Handle Recognition Error
  void onRecognitionError(dynamic n) {

    vm.setRecordingState(false);

    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      vm.handleIOSRecognitionError();
    }
    
    if (platform == TargetPlatform.android) {
      final code = n != null ? int.parse('$n') : null;
      vm.handleAndroidRecognitionError(code);
    }

  }

  
  /// [ void ] CallBack to handle the speech availability 
  void onSpeechAvailability(bool result) {

    setState(() => recognitionAvailable = result );

  }


  /// [ void ] Set Current Locale Language
  void onCurrentLocale(String locale) {

    setState(() {
      language = languages.firstWhere(
        (lang) => lang.code == locale
      );
    });

  }


  /// [ void ] Callback to handle the start of speech recognition
  void onRecognitionStart() {

    vm.setRecordingState(true);

  }


  /// [ void ] Callback that is called when the speech recognition return a partial transcription
  void onRecognitionResult(String txt) {

    print('Partial Transcription: $txt');

  }


  /// [ void ] Callback that is called when a successful voice recognition is completed
  /// or when speech recognition stops for some error or when speech recognition is cancelled
  void onRecognitionComplete(String term) {

    print('______________________________________________: $term - ${term.length}');

    vm.setRecordingState(false);

    final transcription = term.trim().toLowerCase();

    if (transcription.length > 0 && !popScopeInProgress) {
      vm.validateResult(transcription);
    }

  }


  void startRecognition() {

    vm.stopTts();

    vm.setRecordingState(true);

    speechRecognition
      .listen(locale: language.code)
      .then((result) => print('Recognition: $result') ); 

  }


  void cancelRecognition() {

    speechRecognition
      .cancel()
      .then((result) {
        vm.setRecordingState(result);
      });

  }


  void stopRecognition() {

    speechRecognition
      .stop()
      .then((result) {
        vm.setRecordingState(result);
      });

  }


  String generateUrl(String name) => 'assets/flare/$name.flr';


  void next() async {

    final nextIndex = vm.currentIndex + 1;

    if (nextIndex == vm.data.length) {
      vm.navigateToReadingCourseHome();
      return;
    }



    if (nextIndex < vm.data.length) {
      print('Changedata');
      vm.changeCurrentData();
      vm.hideDialog();
      await nextPage();
      vm.speakInstructions();
    }



  }

  Future<void> nextPage() {
    return _pageController.nextPage(
      duration: Duration(milliseconds: 1300),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  Future<bool> validateIfIsRecording() async {

    if (vm.isRecording) {
      setState(() => popScopeInProgress = true );
      cancelRecognition();
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: validateIfIsRecording,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[


            ScrollConfiguration(
              behavior: MyBehavior(),
              child: PageView.builder(
                physics:     NeverScrollableScrollPhysics(),
                itemCount:   vm.data.length,
                controller:  _pageController,
                itemBuilder: (_, i) => buildLetter(vm.data[i].letter) ,
              ),
            ),

            buildButtonRecord(),
            
            vm.showWellDoneDialog
            ? Container(
                child: WellDoneDialogApp(
                onStart: vm.speakWellDone,
                onEnd: next,
              )
            )
            : Offstage(),


          ],
        ),
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
              child: vm.currentData.attempts >= 3
                ? buildButtonHelp()
                : Offstage(),
            ),
          ),

          vm.isRecording
          ? Container(
            height: 45.0,
            child:  FlareActor(

              generateUrl('recording'),
              animation: 'record',
              fit:        BoxFit.fitHeight,
              color:      Colors.orange[300],

            ),
          )
          : Container(
            height: 45.0,
            child: FlareActor(

              generateUrl('points'),
              fit:   BoxFit.fitHeight,
              color: Colors.orange[300],

            ),
          ),

          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only( bottom: 20.0, top: 10.0 ),
            child: CustomCircularIconButton(
              onTap: vm.isRecording ? null : startRecognition,
              color: Theme.of(context).primaryColor,
              width:  68.0,
              height: 68.0,
              elevation: 3.0,
              splashColor: Colors.white12,
              icon: Icon(
                vm.isRecording ? Icons.hearing : Icons.mic,
                color: Colors.white,
                size:  34.0,
              ),
            )

          )


        ],
      ),
    );



  }


  Widget buildButtonHelp() {

    return CustomCircularIconButton(
      icon: Icon(
        Icons.help_outline,
        color: Colors.orange[400],
        size: 42.0,
      ),
      onTap:  vm.speakHelp,
      width:  56.0,
      height: 56.0,
      splashColor: Colors.orange[50],
    );

  }




}


class Language {

  final String name;
  final String code;

  Language(this.name, this.code);

}

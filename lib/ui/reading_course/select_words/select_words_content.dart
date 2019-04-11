import 'package:app19022019/core/src/viewmodels/reading_course/select_words_view_model.dart';
import 'package:app19022019/ui/components/progress_bar_indicator.dart';
import 'package:flutter/material.dart';

class SelectWordsContent extends StatelessWidget {

  final SelectWordsViewModel viewModel;

  const SelectWordsContent({
    Key key,
    @required this.viewModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[

          Positioned(
            height: 10.0,
            right:  00.0,
            left:   00.0,
            top:    25.0,
            child: ProgressBarIndicator(
              p:      00.5,
              h:      10.0,
              w:      size.width * 0.90,
              radius: 50.0,
            ),
          ),

          Container(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              children:  List.generate(
                viewModel.currentData.words.length,
                (i) => SelectWordsButton(
                  word:      viewModel.currentData.words[i],
                  letter:    viewModel.currentData.letter,
                  context:   context,
                  onPressed: viewModel.onSelectWord,
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

}


class SelectWordsButton extends StatefulWidget {

  final String word;
  final String letter;
  final BuildContext context;
  final Function(String word) onPressed;

  SelectWordsButton({
    Key key,
    @required this.word,
    @required this.letter,
    @required this.context,
    @required this.onPressed,
  }) : super(key: key);


  @override
  _SelectWordsButtonState createState() => _SelectWordsButtonState();

}

class _SelectWordsButtonState extends State<SelectWordsButton> {


  String get word => widget.word;
  String get letter => widget.letter;
  BuildContext get ctx => widget.context;
  Function(String word) get onPressed => widget.onPressed;

  MaterialColor color;
  MaterialColor successColor;
  MaterialColor wrongColor;
  bool hasBeenPressed;


  @override
  void initState() {

    super.initState();
    color = Theme.of(ctx).primaryColor;
    successColor = Colors.green;
    wrongColor = Colors.red;
    hasBeenPressed = false;

  }


  void onTap() {

    final bool isCorrect = word.contains(letter);

    if (isCorrect) {

      setState(() => color = successColor );

    } else {

      setState(() => color = wrongColor );

    }

    setState(() => hasBeenPressed = true );
    onPressed(word);

  }


  @override
  Widget build(BuildContext context) {

    final BorderRadius _radius = BorderRadius.circular(4.0);

    return Container(

      margin: EdgeInsets.only(

        top:    2.0,
        left:   3.0,
        right:  3.0,
        bottom: 10.0

      ),
      decoration: BoxDecoration(

        borderRadius: _radius,
        boxShadow: [
          BoxShadow( color: color[700], offset: Offset(0, 7) ),
          BoxShadow( color: color ),
        ]

      ),
      child: Material(

        color: color,
        borderRadius: _radius,
        child: InkWell(
          onTap:          !hasBeenPressed ? onTap : null,
          splashColor:    Colors.black12,
          borderRadius:   _radius,
          splashFactory:  InkRipple.splashFactory,
          highlightColor: Colors.transparent,
          child: Container(

            decoration: BoxDecoration(
              borderRadius: _radius,
            ),

            padding: EdgeInsets.symmetric(
              vertical:   7.0,
              horizontal: 20.0
            ),

            child: Text(
              word,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.80,
              ),
            ),

          ),

        ),

      ),
    );

  }


}
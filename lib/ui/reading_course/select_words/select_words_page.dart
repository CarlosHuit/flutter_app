
import 'package:app19022019/core/src/redux/reading_course/rc_select_words/rc_select_words_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/select_words_view_model.dart';
import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:app19022019/ui/components/progress_bar_indicator.dart';
import 'package:app19022019/ui/reading_course/select_words/select_words_button.dart';
import 'package:flutter/material.dart';

class SelectWordsPage extends StatelessWidget {

  final RCSelectWordsData data;
  final SelectWordsViewModel vm;
  SelectWordsPage({
    Key key,
    @required this.data,
    @required this.vm
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[

        Positioned(
          height: 10.0,
          right:  00.0,
          left:   00.0,
          top:    25.0,
          child: ProgressBarIndicator(
            p:      vm.percentPendings,
            h:      10.0,
            w:      size.width * 0.90,
            radius: 50.0,
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          alignment: Alignment.center,
          child: Wrap(
            alignment: WrapAlignment.center,
            children:  List.generate(
              data.words.length,
              (i) => SelectWordsButton(
                word:      data.words[i],
                letter:    data.letter,
                context:   context,
                onPressed: vm.onSelectWord,
              )
            ),
          ),
        ),

        Positioned(
          bottom: 10.0,
          left: 10.0,
          child: CustomCircularIconButton(
            height: 48.0,
            width:  48.0,
            onTap:  vm.speakInstructions,
            splashColor: Colors.orange[100],
            icon: Icon(
              Icons.help_outline,
              color: Colors.orange,
              size: 36.0,
            ),
          ),
        )

      ],
    );

  }

}

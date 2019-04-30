import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:flutter/material.dart';

class TextFieldWriteAnswer extends StatefulWidget {

  final Function(String term) onSubmit;

  const TextFieldWriteAnswer({
    Key key,
    @required this.onSubmit
  }) : super(key: key);

  @override
  _TextFieldWriteAnswerState createState() => _TextFieldWriteAnswerState();
}


class _TextFieldWriteAnswerState extends State<TextFieldWriteAnswer> {

  Function(String term) get onSubmit => widget.onSubmit;

  TextEditingController _controller;

  BoxDecoration _decoration = BoxDecoration(

    color:        Colors.white,
    borderRadius: BorderRadius.circular(4.0),
    boxShadow: [  BoxShadow( color: Colors.black26, blurRadius: 2.0 ) ]

  );


  InputDecoration _inputDecoration = InputDecoration(

    enabledBorder:  InputBorder.none,
    disabledBorder: InputBorder.none,
    border:         InputBorder.none,

  );


  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }


  void onSubmitAnswer() {

    final term = _controller.value.text.trim();

    if (term.length > 0) {
      FocusScope.of(context).requestFocus(new FocusNode());
      onSubmit(term);
    }

  }


  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.symmetric(vertical: 5.0),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[


          Expanded(
            child: Container(
              margin:    EdgeInsets.only(
                left: 0.0,
                right: 5.0
              ),
              alignment: Alignment.center,
              child: Container(
                decoration: _decoration,
                padding:    EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  maxLines:     null,
                  autofocus:    true,
                  controller:   _controller,
                  decoration:   _inputDecoration,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
          ),


          Container(
            width:     44.0,
            height:    44.0,
            alignment: Alignment.center,
            child: CustomCircularIconButton(
              height: 42,
              width:  42,
              onTap:  onSubmitAnswer,
              icon:   Icon( Icons.send, color: Colors.blue, size: 28.0 ),
              splashColor: Colors.blue[50],
            )
          )


        ],
      ),
    );

  }


}



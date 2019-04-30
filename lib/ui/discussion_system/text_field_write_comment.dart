import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:flutter/material.dart';

class TextFieldWriteComment extends StatefulWidget {

  final Function(String term) onSubmit;

  const TextFieldWriteComment({
    Key key,
    @required this.onSubmit
  }) : super(key: key);

  @override
  _TextFieldWriteCommentState createState() => _TextFieldWriteCommentState();

}


class _TextFieldWriteCommentState extends State<TextFieldWriteComment> {


  TextEditingController _controller;
  Function(String term) get onSubmit => widget.onSubmit;


  BoxDecoration _boxDecoration = BoxDecoration(
    color:        Colors.white,
    borderRadius: BorderRadius.circular(4.0),
    boxShadow: [
      BoxShadow( color: Colors.black26, blurRadius: 2.0 )
    ]
  );


  InputDecoration _inputDecoration = InputDecoration(
    enabledBorder:  InputBorder.none,
    disabledBorder: InputBorder.none,
    border: InputBorder.none,
  );



  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void onSubmitComment() {

    final term = _controller.value.text.trim();

    if (term.length > 0) {
      FocusScope.of(context).requestFocus(new FocusNode());
      onSubmit(term);
      _controller.clear();
    }

  }


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[


          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin:    EdgeInsets.only( left: 15.0, right: 5.0 ),
              child:     Container(

                padding:    EdgeInsets.symmetric(horizontal: 15.0),
                decoration: _boxDecoration,
                child: TextField(

                  maxLines:     null,
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
              height: 42.0,
              width:  42.0,
              onTap:  onSubmitComment,
              icon:   Icon( Icons.send, color: Colors.blue, size: 32.0 ),
              splashColor: Colors.blue[50],
            )
          )


        ],
      ),
    );

  }


}



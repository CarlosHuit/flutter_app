import 'package:flutter/material.dart';

class ItemLetterButton extends StatefulWidget {

  final String letter;
  final String correctLetter;
  final Function(String sel) onSelect;

  const ItemLetterButton({
    Key key,
    @required this.letter,
    @required this.correctLetter,
    @required this.onSelect,
  }) : super(key: key);

  @override
  _ItemLetterButtonState createState() => _ItemLetterButtonState();

}

class _ItemLetterButtonState extends State<ItemLetterButton> {

  String get letter => widget.letter;
  String get correctLetter => widget.correctLetter;
  Function(String sel) get onSelect => widget.onSelect; 

  Color color;
  Color colorShadow;
  bool  wasPressed;


  @override
  void initState() {

    super.initState();
    color       = Colors.lightBlue;
    wasPressed  = false;
    colorShadow = Colors.lightBlue[700];

  }


  void changeColor() {

    if (wasPressed == false) {

      onSelect(letter);

      if (letter == correctLetter) {
        changeToSuccessColor();
      } else {
        changeToWrongColor();
      }

    }

    wasPressed = true;

  }


  void changeToSuccessColor() {

    setState(() {
      color = Colors.green;
      colorShadow = Colors.green[700];
    });

  }


  void changeToWrongColor() {

    setState(() {
      color = Colors.red;
      colorShadow = Colors.red[700];
    });

  }


  @override
  Widget build(BuildContext context) {
 
    return AnimatedContainer(

      margin:      EdgeInsets.only(bottom: 8, left: 1.5, right: 1.5),
      duration:    Duration(microseconds: 200),
      alignment:   Alignment.center,
      constraints: BoxConstraints(

        maxWidth:  50.0,
        minWidth:  48.0,
        minHeight: 80.0,
        maxHeight: 80.0

      ),
      decoration: BoxDecoration(

        color:        color,
        borderRadius: BorderRadius.circular(3.0),
        boxShadow:  [ BoxShadow( color:  colorShadow, offset: Offset(0, 8) ) ]

      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[


          Container(
            alignment: Alignment.center,
            child: Text(
              widget.letter,
              style: TextStyle(
                color:    Colors.white,
                fontSize: 36.0
              ),
            ),
          ),

          Container(
            child: Material(

              color: Colors.transparent,
              type:  MaterialType.button,
              child: InkWell(

                splashColor:   Colors.black12,
                splashFactory: InkRipple.splashFactory,
                onTap: wasPressed == false ? changeColor : null,
                
              ),

            ),
          )


        ],
      ),

    );

  }


}
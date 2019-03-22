import 'package:flutter/material.dart';

class FindLettersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final word = 'carro';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: size.width * .95,
          height: size.height * .95,
          child: Card(

            child: Container(
              height: size.height * .95,
              width: size.width * 0.95,
              margin: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[


                  Container(
                    alignment: Alignment.center,
                    height: 300.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                      color:        Color.fromARGB(255, 34, 34, 34),
                      border:       Border.all(width: 5.0, color: Colors.deepOrange[400]),
                      borderRadius: BorderRadius.circular(150.0),
                    ),
                    child: Container(
                      width:     200.0,
                      height:    200.0,
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('assets/img100X100/carro-min.png'),
                      )
                    ),
                  ),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate( word.length, (i) => ItemLetterButton(
                      letter: word[i],
                      correctLetter: 'l',
                    )),
                  ),


                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}


class ItemLetterButton extends StatefulWidget {

  final String letter;
  final String correctLetter;

  const ItemLetterButton({
    Key key,
    @required this.letter,
    @required this.correctLetter
  }) : super(key: key);

  @override
  _ItemLetterButtonState createState() => _ItemLetterButtonState();

}

class _ItemLetterButtonState extends State<ItemLetterButton> {

  String get letter => widget.letter;
  String get correctLetter => widget.correctLetter;
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

      if (letter == correctLetter)
        changeToSuccessColor();
      else
        changeToWrongColor();

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
      duration:  Duration(microseconds: 200),
      margin:    EdgeInsets.symmetric(horizontal: 2.0),
      alignment: Alignment.center,
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
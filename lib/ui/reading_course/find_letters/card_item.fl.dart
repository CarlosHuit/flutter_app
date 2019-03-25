import 'package:app19022019/core/src/viewmodels/reading_course/find_letters_view_model.dart';
import 'package:flutter/material.dart';
import './item_letter_button.dart';

class CardItemFL extends StatelessWidget {

  final String               urlImg;
  final List<String>         letters;
  final String               correctLetter;
  final FindLettersViewModel viewModel;

  const CardItemFL({
    Key key,
    @required this.urlImg,
    @required this.letters,
    @required this.correctLetter,
    @required this.viewModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final intRadius = 25.0;

    return Container(
      decoration: BoxDecoration(

        color:        Colors.white,
        borderRadius: BorderRadius.circular(intRadius),
        boxShadow:  [ BoxShadow( color: Colors.black54, blurRadius: 3.0 ) ],
        border:       Border.all( color: Colors.yellow[200], width: 4.0 )

      ),
      alignment: Alignment.center,
      margin:    EdgeInsets.symmetric(vertical: 25.0),
      child:     Column(

        mainAxisSize: MainAxisSize.max,
        children: <Widget>[


          Expanded(
            
            child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft:  Radius.circular(intRadius),
                  topRight: Radius.circular(intRadius),
                ),
              ),

              padding: EdgeInsets.only(
                top:   10.0,
                left:  10.0,
                right: 10.0
              ),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                mainAxisSize:       MainAxisSize.max,
                children: <Widget>[


                  Container(
                    alignment: Alignment.center,
                    height:    300.0,
                    width:     300.0,

                    decoration: BoxDecoration(
                      color:        Color.fromARGB(255, 34, 34, 34),
                      border:       Border.all(width: 5.0, color: Colors.deepOrange[400]),
                      borderRadius: BorderRadius.circular(150.0),
                    ),

                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[

                        Container(
                          width:     180.0,
                          height:    180.0,
                          alignment: Alignment.center,
                          child:     Image( image: AssetImage(urlImg) )
                        ),

                        Material(
                          color:        Colors.transparent,
                          borderRadius: BorderRadius.circular(150),

                          child: InkWell(
                            borderRadius:   BorderRadius.circular(150.0),
                            highlightColor: Colors.transparent,
                            onTap:          viewModel.listenWord,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150.0)
                              ),
                            ),
                          ),

                        )


                      ],
                    ),

                  ),


                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children:List.generate(
                          letters.length, (i) => ItemLetterButton(
                            correctLetter: correctLetter,
                            onSelect:      viewModel.selectLetter,
                            letter:        letters[i],
                          )
                        )

                      ),
                    ),
                  )


                ],
              ),
            ),
          ),


          Container(
            height: 60.0,
            decoration: BoxDecoration(

              color: Colors.yellow[100],
              borderRadius: BorderRadius.only(
                bottomLeft:  Radius.circular(intRadius - 5.0),
                bottomRight: Radius.circular(intRadius - 5.0)
              ),

            ),
            child: Material(

              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  bottomLeft:  Radius.circular(intRadius - 5.0),
                  bottomRight: Radius.circular(intRadius - 5.0)
                ),
                onTap: viewModel.listenInstructions,
                splashColor:    Colors.orange[200],
                splashFactory:  InkRipple.splashFactory,
                highlightColor: Colors.transparent,

                child: Container(

                  child: Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'AYUDA',
                        style: TextStyle(
                          color:      Colors.blueGrey[800],
                          fontWeight: FontWeight.bold,
                          fontSize:   22.0,
                        ),
                      ),

                      SizedBox(width: 5.0),

                      Icon(
                        Icons.volume_up,
                        size:  28.0,
                        color: Colors.blueGrey[800]
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
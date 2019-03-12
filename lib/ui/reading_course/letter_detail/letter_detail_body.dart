
import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/reading_course/letter_detail/option_card.dart';
import 'package:flutter/material.dart';

class LetterDetailBody extends StatelessWidget {

  final LetterDetailViewModel vm;

  const LetterDetailBody({ Key key, @required this.vm }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[

        Container(
          child: Container(
            alignment:  Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit:   BoxFit.fitHeight,
                image: AssetImage("assets/star-pattern.png"),
              ),
              gradient: LinearGradient(
                stops:    [0.0, 0.8],
                begin: Alignment.bottomLeft,
                end:   Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 11, 62, 113),
                  Color.fromARGB(255, 13, 100, 176)
                ]
              )
            ),

            child: Container(
              width:  size.width * .90,
              height: ((size.width * 0.90) / 3) * 4,
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap:     true,
                physics:        NeverScrollableScrollPhysics(),
                padding:        EdgeInsets.all(1.0),
                children:       List.generate(
                  vm.options.length,
                  (i) => OptionCard(
                    vm: vm,
                    letterId:    '${vm.options[i]}$i',
                    hideAllCars:  vm.hideAllCards,
                    showAllCards: vm.showAllCards,
                  )
                ),
              ),
            ),

          )

        ),

        ModalError(),
        ModalSuccess(),
      ]
    );

  }

}

class ModalError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.black38,
        backgroundBlendMode: BlendMode.darken
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(seconds: 1),
            width: size.width,
            transform: Matrix4.translationValues(0, -50, 0),
            height: 120.0,
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.redAccent[100],
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(width: 4.0, color: Colors.red[600]),
              boxShadow: <BoxShadow> [
                BoxShadow(color: Colors.black45, blurRadius: 10.0, spreadRadius: 5.0 ),
                BoxShadow(color: Colors.white, spreadRadius: 2.0 )
              ]
            ),
            child: Row(
              children: <Widget>[

                Icon(
                  Icons.error_outline,
                  color: Colors.red[600],
                  size:  64.0,
                  semanticLabel: 'ss',
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '¡Uppss!',
                        textAlign: TextAlign.center,
                        style:     TextStyle(
                          color:      Colors.red[600],
                          fontWeight: FontWeight.bold,
                          fontSize:   36.0
                        ),
                      ),
                      Text(
                        'Vuelve a intentarlo',
                        style: TextStyle(
                          color:      Colors.red[600],
                          fontSize:   16.0,
                          fontWeight: FontWeight.bold
                        ),
                      )

                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}

class ModalSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width:  size.width,
      decoration: BoxDecoration( color: Colors.black26 ),
      child:      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          AnimatedContainer(
            width:      size.width,
            height:     120.0,
            transform:  Matrix4.translationValues(0, -350, 0),
            duration:   Duration(milliseconds: 1000),
            margin:     EdgeInsets.all(20.0),
            padding:    EdgeInsets.all(10.0),
            decoration: BoxDecoration(

              color:        Colors.greenAccent[100],
              borderRadius: BorderRadius.circular(3.0),
              border:       Border.all(width: 4.0, color: Colors.greenAccent[700]),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black45, blurRadius: 10.0, spreadRadius: 5.0),
                BoxShadow(color: Colors.white, spreadRadius: 2)
              ],

            ),
            child: Row(
              children: <Widget>[


                Icon(
                  Icons.check_circle_outline,
                  color: Colors.greenAccent[700],
                  size:  64.0,
                ),


                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        '¡Bien Hecho!',
                        textAlign: TextAlign.center,
                        style:     TextStyle(
                          color:      Colors.greenAccent[700],
                          fontWeight: FontWeight.bold,
                          fontSize:   36.0
                        ),
                      ),

                    ],
                  ),
                )


              ],
            ),
          )
        ],
      ),
    );

  }
}
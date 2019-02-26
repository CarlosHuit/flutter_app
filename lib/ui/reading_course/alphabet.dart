import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';



Widget alphabet({@required BuildContext context, FlutterTts flutterTts}) {

  final size = MediaQuery.of(context).size;
  final letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'o', 'p',
  'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];

  return Container(

    child: ListView.builder(
      padding:     EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
      physics:     BouncingScrollPhysics(),
      shrinkWrap:  true,
      itemCount:   letters.length,
      itemBuilder: (context, index) {
        return itemCardLetter(size: size, letter: letters[index], flutterTts: flutterTts);
      },
    ),
  );


}




Widget itemCardLetter({@required Size size, @required String letter, @required FlutterTts flutterTts }) {


  final Radius radius4 = Radius.circular(4.0);
  final BorderRadius radiusLeft =  BorderRadius.only(topLeft: radius4, bottomLeft: radius4);
  final BorderRadius radiusRight = BorderRadius.only(topRight: radius4, bottomRight: radius4);

  final letterItem = (String letter) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        letter,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 68.0
        ),
      ),
    );

  };



  return Container(

    height: 108.0,
    child:  Card(


      child: Row(
        children: <Widget>[



          Expanded(

            child: Container(
              decoration: BoxDecoration( borderRadius: radiusLeft ),
              child: Stack(
                children: <Widget>[


                  Container(
                    height: 100.0,
                    child: Material(
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashFactory: InkRipple.splashFactory,
                        onTap: () => print('$letter has been Selected'),
                        child: Container(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              letterItem(letter.toUpperCase()),
                              letterItem(letter.toLowerCase())

                            ],
                          ),

                        ),
                      ),
                    ),
                  ),


                  Container(
                    height:     100.0,
                    width:      60.0,
                    decoration: BoxDecoration( borderRadius: radiusLeft ),

                    child: Material(

                      color:        Colors.transparent,
                      borderRadius: radiusLeft,
                      child:        InkWell(
                        splashFactory: InkRipple.splashFactory,
                        splashColor:    Colors.orange[100],
                        highlightColor: Colors.transparent,
                        child: Icon( Icons.play_circle_outline, size:  42.0, color: Colors.orangeAccent ),
                        onTap: () => _speak(flutterTts: flutterTts),

                      ),

                    )
                  ),


                ],
              ),
            ),

          ),



          Container(

            width:  100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: radiusRight
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Image(image: AssetImage('assets/user-min.png'),),
                ),
                Container(
                  child: Material(
                    
                    color: Colors.transparent,
                    child: InkWell(
                      splashFactory: InkRipple.splashFactory,                 
                      highlightColor: Colors.transparent,
                      onTap: () {},
                    ),

                  ),
                )
              ],
            ),

          )



        ],
      ),


    ),

  );


}

Future _speak({ @required FlutterTts flutterTts }) async{

  try {

    await flutterTts.setLanguage("es-US");
    await flutterTts.setSpeechRate(1.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    // await flutterTts.isLanguageAvailable("en-US");

    final int result = await flutterTts.speak('Hola Mundo, esto es un ejemplo de sintesis de voz');
    print('result $result');
    
  } catch (e) {
    print('spech: Ha ocurrido un error');
    print(e);
  }



}


Widget tabAlphabet() {

  return Tab(
    
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.font_download, color: Colors.yellow,),
        SizedBox(width: 5.0,),
        Text(
          'Abecedario',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0
          ),
        )
      ],

    )

  );

}

import 'package:app19022019/core/src/redux/reading_course/rc_find_letters/rc_find_letters_state.dart';
import 'package:app19022019/ui/reading_course/find_letters/item_letter_button.dart';
import 'package:flutter/material.dart';

class FindLettersPage extends StatelessWidget {

  final FLData data;

  FindLettersPage({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size =MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Colors.grey[100],
      body: Container(
        alignment: Alignment.center,
        child: Card(
          child: Container(
            height: size.height * .95,
            width: size.width * 0.95,
            decoration: BoxDecoration(
              // color: Colors.green,
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(4.0),
              // border: Border.all(color: Colors.green, width: 4.0)
              // boxShadow: [ BoxShadow(color: Colors.black38, blurRadius: 1.0) ]
            ),
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
                      image: AssetImage('assets/img100X100/${data.word}-min.png'),
                    )
                  ),
                ),


                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      data.word.length,
                      (i) => ItemLetterButton( letter: data.word[i], correctLetter: data.letter )
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}


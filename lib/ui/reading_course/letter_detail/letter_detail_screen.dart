import 'dart:async';

import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/reading_course/letter_detail/option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';



class LetterDetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, LetterDetailViewModel>(
      distinct:  true,
      onInit: (store) {
        final String letter = store.state.readingCourseState.letterDetail.currentData.letter;
        Future.delayed(Duration(milliseconds: 0), () => _showModalSheet(letter, context));
      },
      converter: (store) => LetterDetailViewModel.fromStore(store),
      builder:   (BuildContext _, LetterDetailViewModel vm) {



        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            child:           Icon(Icons.arrow_upward, size: 28.0,),
            onPressed:       () => _showModalSheet(vm.letter, context),
            mini: true,
          ),
          body: LetterDetailBody(vm: vm)
        );

      },
    );

  }
  
  void _showModalSheet(String letter, BuildContext context) {
    
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          color:   Colors.grey[400],
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child:   Card(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  letter,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                    fontSize: 200.0,
                    shadows: <Shadow> [
                      Shadow(color: Colors.black, offset: Offset(-1.2, 1.2)),
                      Shadow(color: Colors.black, offset: Offset(1.2, -1.2)),
                      Shadow(color: Colors.black, offset: Offset(1.2, 1.2)),
                      Shadow(color: Colors.black, offset: Offset(-1.2, -1.2)),
                      Shadow(color: Colors.black, blurRadius: 15.0),
                    ]
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 40.0,
                  margin: EdgeInsets.only(top: 10.0),
                  child: RaisedButton(

                    onPressed: () => Navigator.pop(context),
                    color:     Colors.red,
                    child:     Text(
                      'Continuar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:      Colors.white,
                        fontSize:   18.0
                      ),
                    ),

                  )
                ),

              ],
            )

            )
        );
      }
    ).whenComplete(() => print('closed ${DateTime.now()}'));
  }

}



class LetterDetailBody extends StatelessWidget {

  final LetterDetailViewModel vm;

  const LetterDetailBody({ Key key, @required this.vm }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      child: Container(
        alignment:  Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit:   BoxFit.fitHeight,
            image: AssetImage("assets/star-pattern.png"),
          ),
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            stops:    [0.0, 1],
            begin:    Alignment.bottomCenter,
            end:      Alignment.topCenter,
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

    );

  }

}


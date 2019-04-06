import 'package:app19022019/core/src/redux/reading_course/rc_data/rc_data_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/reading_course_view_model.dart';
import 'package:app19022019/ui/components/loading_indicator.dart';
import 'package:app19022019/utils/my_behavior.dart';
import 'package:flutter/material.dart';



class LearnedLetters extends StatelessWidget {

  final BuildContext context;
  final ReadingCourseViewModel viewModel;

  const LearnedLetters({Key key, this.context, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (viewModel.isLoading == true) {
      return LoadingIndicator();
    }

    if (viewModel.isLoading == false) {
      return viewModel.learnedLetters.length > 0
        ? LearnedLettersView(vm: viewModel)
        : NoLearnedLettersView();

    }

    return null;

  }
}



class NoLearnedLettersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        alignment:  Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border:       Border.all( width: 1.0, color: Colors.grey[400] ),
        ),
        width:  320.0,
        height: 150.0,
        child: Text(
          'Aquí aparecerán las letras que vayas aprendiendo',
          textAlign: TextAlign.center,
          style:     TextStyle(
            fontSize:   24.0,
            color:      Colors.grey[500],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}



class LearnedLettersView extends StatelessWidget {

  final ReadingCourseViewModel vm;

  const LearnedLettersView({Key key, this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(10.0),
      child:   ListView.builder(
        
        shrinkWrap:  true,
        physics:     BouncingScrollPhysics(),
        itemCount:   vm.learnedLetters.length,
        itemBuilder: (BuildContext context, int i) {

          return ItemLearnedLetter( learnedLetter: vm.learnedLetters[i], viewModel: vm);

        },

      )

    );
  }
}



class ItemLearnedLetter extends StatelessWidget {

  final LearnedLetter learnedLetter;
  final ReadingCourseViewModel viewModel;

  const ItemLearnedLetter({Key key, this.learnedLetter, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 1.0,
      shape:     RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
      margin:    EdgeInsets.symmetric(vertical: 4.0),
      child: ExpansionTile(

        
        leading: Container(
          height: 40.0,
          width: 30.0,
          // color: Colors.red,
          child: Icon(Icons.favorite, color: Colors.red,),
        ),
        title:   Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[


            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    learnedLetter.letter.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 42.0
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    learnedLetter.letter.toLowerCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 42.0
                    ),
                  ),

                ],
              ),
            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: List.generate(
                  learnedLetter.rating,
                  (index) => Icon(
                    Icons.star,
                    color: Colors.yellow
                  )
                )
              ),
            ),

          ],

        ),


        children: <Widget>[

          Container(
            height: 80.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border.all(color: Colors.grey[200], width: 1.2),
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: Container(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Row(),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    runSpacing: 0.0,
                    spacing: 5.0,
                    runAlignment: WrapAlignment.center,

                    children: <Widget>[

                      /// Todo add methods to listen letters
                      CustomButton(
                        letter: learnedLetter.letter.toUpperCase(),
                        color: Theme.of(context).primaryColor,
                        onTap: ( ) => print('pressed'),
                      ),

                      CustomButton(
                        letter: learnedLetter.letter.toLowerCase(),
                        color: Theme.of(context).primaryColor,
                        onTap: ( ) => print('pressed'),
                      ),


                    ],
                  )
                ]
              ),
            ),
          ),




          Container(
            margin:  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color:        Colors.grey[100],
              border:       Border.all(width: 1.0, color: Colors.grey[300]),
              borderRadius: BorderRadius.all(Radius.circular(3.0))
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Row(),
                Wrap(

                  alignment: WrapAlignment.center,
                  spacing:    7.0,
                  runSpacing: 10.0,
                  children: List.generate(
                    learnedLetter.combinations.length,
                    (i) => Container(
                      width: 90.0,
                      height: 40.0,
                      child: RaisedButton(
                        color:     Colors.red,
                        textColor: Colors.white,
                        highlightElevation: 4.0,
                        onPressed: () => viewModel.speak(term: learnedLetter.combinations[i].p),
                        child: Text(

                          learnedLetter.combinations[i].w,

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            fontSize: 24.0
                          ),
                        ),
                      )
                    )
                  )
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
            child: Container(
              width: 225.0,
              height: 40.0,
              child: RaisedButton(
                highlightElevation: 6.0,
                color: Colors.green,
                textColor: Colors.white,
                child: Text(
                  'Volver a praticar',
                  style: TextStyle( fontWeight: FontWeight.bold, fontSize: 19.0, letterSpacing: 0.8 ),
                ),
                onPressed: () => viewModel.startCourse(learnedLetter.letter) ,
              ),
            )
          )


        ],
      )
    );
  }

}




class TabLearnedLetters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.favorite, color: Colors.red,),
          SizedBox(width: 5.0,),
          Text(
            'Aprendidas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {

  final String letter;
  final Function() onTap;
  final MaterialColor color;

  const CustomButton({
    Key key,
    @required this.letter,
    @required this.onTap,
    @required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:      120.0,
      height:     45.0,
      alignment:  Alignment.center,
      margin:     EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical:   6.0
      ),
      decoration: BoxDecoration(
        color:        color,
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: [

          BoxShadow(
            color: color[700],
            offset: Offset(0, 6)
          )

        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              
              splashFactory: InkRipple.splashFactory,
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  letter,
                  textAlign: TextAlign.center,
                  style: TextStyle(

                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0

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
import 'package:app19022019/core/src/redux/reading_course/rc_data/rc_data_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/reading_course_view_model.dart';
import 'package:app19022019/ui/components/loading_indicator.dart';
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
        itemBuilder: (_, i) => ItemLearnedLetter(
          viewModel: vm,
          learnedLetter: vm.learnedLetters[i],
        )


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

    final _decoration = BoxDecoration(
      color: Colors.grey[50],
      border: Border.all(color: Colors.grey[200], width: 1.2),
      borderRadius: BorderRadius.circular(5.0)
    );

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
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            padding: EdgeInsets.only(bottom: 17.0, top: 10.0),
            decoration: _decoration,
            child: Stack(
              alignment: Alignment.center,
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
                      term: learnedLetter.letter.toUpperCase(),
                      color: Theme.of(context).primaryColor,
                      onTap: ( ) => print('pressed'),
                    ),

                    CustomButton(
                      term: learnedLetter.letter.toLowerCase(),
                      color: Theme.of(context).primaryColor,
                      onTap: ( ) => print('pressed'),
                    ),


                  ],
                )
              ]
            ),
          ),


          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10.0, bottom: 17.0),
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: _decoration,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Row(),
                Wrap(

                  alignment: WrapAlignment.center,
                  children: List.generate(
                    learnedLetter.combinations.length,
                    (i) => CustomButton(
                      term: learnedLetter.combinations[i].w,
                      color: Colors.red,
                      onTap: () => viewModel.speak(term: learnedLetter.combinations[i].p),
                      height: 36.0,
                      width: 80.0,
                      fontSize: 24,
                    )  
                  ),

                )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: CustomButton(
              width: 200.0,
              height: 40.0,
              term: 'Volver a practicar',
              color: Colors.green,
              onTap: () => viewModel.startCourse(learnedLetter.letter),
              fontSize: 18.0,
            ),
          ),


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

  final String term;
  final Function() onTap;
  final MaterialColor color;
  final double width;
  final double height;
  final double fontSize;

  const CustomButton({
    Key key,
    @required this.term,
    @required this.onTap,
    @required this.color,
    this.width = 120.0,
    this.height = 45.0,
    this.fontSize = 26.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:      width,
      height:     height,
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
                  term,
                  textAlign: TextAlign.center,
                  style: TextStyle(

                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize

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
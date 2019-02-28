import 'package:app19022019/core/src/models/reading_course/rc_data_model.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/reading_course_view_model.dart';
import 'package:flutter/material.dart';



Widget learnedLetters( BuildContext context, ReadingCourseViewModel viewModel ) {


  if (viewModel.isLoading == true) {
    return loadingIndicator();
  }

  if (viewModel.isLoading == false) {
    return learnedLettersView(viewModel);

  }

  return null;

}

Widget learnedLettersView(ReadingCourseViewModel vm) {
  return Container(

    padding: EdgeInsets.all(10.0),
    child:   ListView.builder(
      
      shrinkWrap:  true,
      physics:     BouncingScrollPhysics(),
      itemCount:   vm.learnedLetters.length,
      itemBuilder: (BuildContext context, int i) {

        return itemLearnedLetter( learnedLetter: vm.learnedLetters[i], viewModel: vm);

      },

    )

  );
}




Widget loadingIndicator() {
  return Container(
    padding:   EdgeInsets.only(top: 20.0),
    alignment: Alignment.topCenter,
    child:     CircularProgressIndicator(),
  );
}




Widget itemLearnedLetter({@required LearnedLetter learnedLetter, @required ReadingCourseViewModel viewModel}) {

  return Card(

    elevation: 1.0,
    shape:     RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
    margin:    EdgeInsets.symmetric(vertical: 4.0),
    child: ExpansionTile(

      leading: Icon(Icons.favorite, color: Colors.red,),
      title:   Row(

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
          margin:  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color:  Colors.grey[100],
            border: Border.all(width: 1.0, color: Colors.grey[300]),
            borderRadius: BorderRadius.all(Radius.circular(3.0))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              individualLetterBtn(letter: learnedLetter.letter.toUpperCase(), typeLetter: 'mayúscula', vm: viewModel),
              individualLetterBtn(letter: learnedLetter.letter.toLowerCase(), typeLetter: 'minúscula', vm: viewModel),

            ],
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
              onPressed: () {},
            ),
          )
        )


      ],
    )
  );

}




/// [Widget] return a button with a individual Letter 
Widget individualLetterBtn({
  @required String letter,
  @required String typeLetter,
  @required ReadingCourseViewModel vm
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    width:  120.0,
    height: 50.0,
    child: RaisedButton(
      highlightElevation: 4.0,
      color:     Colors.lightBlue,
      textColor: Colors.white,
      onPressed: () => vm.speak(term: '$letter $typeLetter', rate: 1.0),
      child:     Text(
        letter,
        style: TextStyle( fontWeight: FontWeight.bold, fontSize: 32.0 ),
      ),
    ),
  );
}




Widget tabLearnedLetters() {
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




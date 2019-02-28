import 'package:app19022019/core/src/models/reading_course/rc_data_model.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/reading_course_view_model.dart';
import 'package:flutter/material.dart';



Widget learnedLetters( BuildContext context, ReadingCourseViewModel viewModel ) {


  if (viewModel.isLoading == true) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      alignment: Alignment.topCenter,
      child: CircularProgressIndicator(),
    );
  }

  if (viewModel.isLoading == false) {
    return Container(

      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        
        shrinkWrap:  true,
        physics:     BouncingScrollPhysics(),
        itemCount:   viewModel.learnedLetters.length,
        itemBuilder: (BuildContext context, int i) {

          return itemLearnedLetter( learnedLetter: viewModel.learnedLetters[i], viewModel: viewModel);

        },

      )

    );

  }

  return null;

}

Widget itemLearnedLetter({@required LearnedLetter learnedLetter, @required ReadingCourseViewModel viewModel}) {

  return Card(
    elevation: 1.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
    margin: EdgeInsets.symmetric(vertical: 3.0),
    child: ExpansionTile(

      title: Row(

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
      // backgroundColor: Colors.yellow[50],
      leading: Icon(Icons.favorite, color: Colors.red,),
      // children: list.map((val) => ListTile(title: Text(val),)).toList()
      // children: List.generate(5, (i) => ListTile(title: Text('data $i'),))
      children: <Widget>[

        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: <Widget>[
              Container(
                height: 45.0,
                width: 120.0,
                child: RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () => viewModel.speak(term: '${learnedLetter.letter} mayúscula', rate: 1.0),
                  child: Text(
                    learnedLetter.letter.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0
                    ),
                  ),
                )
              ),
              SizedBox(width: 20.0,),
              Container(
                height: 45.0,
                width: 120.0,
                child: RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () => viewModel.speak(
                    term: '${learnedLetter.letter} minúscula',
                    rate: 1.0
                  ),
                  child: Text(learnedLetter.letter,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0
                  ),
                ),
                )
              )
            ],
          ),
        ),

        Container(

          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Wrap(

            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 5.0,
            children:List.generate(learnedLetter.combinations.length, (i) => RaisedButton(

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
            ))

          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
          child: Container(
            width: 225.0,
            height: 40.0,
            child: RaisedButton(
              color: Colors.orange,
              textColor: Colors.white,
              child: Text(
                'Volver a praticar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0
                ),
              ),
              onPressed: () {},
            ),
          )
        )

      ],
    )
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

















/* 

    return Container(
      child: ListView.builder(
        itemCount: viewModel.learnedLetters.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Row(
              children: <Widget>[
                Text('A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
                Text('a', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
              ],
            ),
            // backgroundColor: Colors.red,

            leading: Icon(Icons.ac_unit),
            children: <Widget>[
              Container(
                color: Colors.red,
                child: Text('12345'),
              )
            ],
          );
        },
      ),

    );

 */
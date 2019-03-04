import 'package:app19022019/core/src/redux/reading_course/rc_data/rc_data_state.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/reading_course_view_model.dart';
import 'package:flutter/material.dart';



class Alphabet extends StatelessWidget {

  final ReadingCourseViewModel viewModel;

  const Alphabet({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if (viewModel.isLoading) {
      return Container(
        alignment: Alignment.topCenter,
        padding:   EdgeInsets.only(top: 10.0),
        child:     CircularProgressIndicator(),
      );
    }

    return Container(

      child: ListView.builder(
        padding:     EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
        physics:     BouncingScrollPhysics(),
        shrinkWrap:  true,
        itemCount:   viewModel.lettersMenu.length,
        itemBuilder: (context, index) {
          return ItemCardLetter(
            size: size,
            item: viewModel.lettersMenu[index],
            viewModel: viewModel,
          );
        },
      ),
    );


  }
}



class ItemLetter extends StatelessWidget {

  final String letter;

  const ItemLetter({Key key, this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}



class ItemCardLetter extends StatelessWidget {

  final Size size;
  final ReadingCourseViewModel viewModel;
  final ItemLetterMenu item;

  const ItemCardLetter({Key key, this.size, this.viewModel, this.item}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final Radius radius4 = Radius.circular(4.0);
    final BorderRadius radiusLeft =  BorderRadius.only(topLeft: radius4, bottomLeft: radius4);
    final BorderRadius radiusRight = BorderRadius.only(topRight: radius4, bottomRight: radius4);



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
                          onTap: () => viewModel.startCourse(item.letter),
                          child: Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                ItemLetter(letter: item.letterUpperCase),
                                ItemLetter(letter: item.letterLowerCase),

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

                          splashFactory:  InkRipple.splashFactory,
                          splashColor:    Colors.orange[100],
                          highlightColor: Colors.transparent,
                          child:          Icon(
                            Icons.play_circle_outline,
                            size:  42.0,
                            color: Colors.orangeAccent
                          ),
                          onTap: () => viewModel.speak(term: item.letter),

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
                    child:   Image(image: AssetImage(item.imgUrl),),
                  ),
                  Container(
                    child: Material(
                      
                      color: Colors.transparent,
                      child: InkWell(
                        splashFactory: InkRipple.splashFactory,                 
                        highlightColor: Colors.transparent,
                        onTap: () => viewModel.startCourse(item.letter),
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


}



class TabAlphabet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}



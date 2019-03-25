import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_find_letters/rc_find_letters_actions.dart';
import 'package:app19022019/core/src/viewmodels/reading_course/find_letters_view_model.dart';
import 'package:app19022019/ui/reading_course/find_letters/item_letter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class FindLettersScreen extends StatefulWidget {

  @override
  _FindLettersScreenState createState() => _FindLettersScreenState();

}

class _FindLettersScreenState extends State<FindLettersScreen> {


  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    pageController.addListener(() {
      print('Current page: ${pageController.page}');
    });

  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, FindLettersViewModel>(

      onInit:    (store) => store.dispatch(RCSetInitialDataFL()),
      converter: (store) => FindLettersViewModel.fromStore(store),
      builder:   (_, vm) {


        return Scaffold(
          backgroundColor: Colors.red,
          body: Container(child: SwipperCards(viewModel: vm,))
        );

        // return ScrollConfiguration(
        //   behavior: MyBehavior(),
        //   child: PageView.builder(
        //     controller: pageController,
        //     itemCount: vm.data.length,
        //     itemBuilder: (_, i) => FindLettersPage( data: vm.data[i] )
        //   ),
        // );

      },

    );

  }
}

class SwipperCards extends StatefulWidget {

  final FindLettersViewModel viewModel;
  SwipperCards({Key key, this.viewModel}) : super(key: key);

  @override
  _SwipperCardsState createState() => _SwipperCardsState();
}

class _SwipperCardsState extends State<SwipperCards> {

  FindLettersViewModel get vm => widget.viewModel;

  SwiperController controller;

  @override
  void initState() {
    super.initState();
    controller = SwiperController();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    return Swiper(

      pagination: SwiperPagination(
        alignment: Alignment.topCenter,
        builder:   SwiperPagination.dots
      ),
      outer:       true,
      scale:       0.85,
      controller:  controller,
      itemCount:   vm.data.length,
      viewportFraction: 0.95,
      itemBuilder: (_, index) => CardItemFL(
        letters:       vm.data[index].letters,
        urlImg:        vm.data[index].imgUrl,
        correctLetter: vm.data[index].letter,
      )

    );


  }
}

class CardItemFL extends StatelessWidget {

  final String urlImg;
  final List<String> letters;
  final String correctLetter;

  const CardItemFL({
    Key key,
    @required this.urlImg,
    @required this.letters,
    @required this.correctLetter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        color:        Colors.white,
        borderRadius: BorderRadius.circular(25.0),
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
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
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

                    child: Container(
                      width:     180.0,
                      height:    180.0,
                      alignment: Alignment.center,
                      child:     Image( image: AssetImage(urlImg) )
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
                            letter: letters[i],
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
                bottomLeft:  Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)
              ),

            ),
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'SIGUIENTE',
                  style: TextStyle(
                    color:      Colors.blueGrey[800],
                    fontWeight: FontWeight.bold,
                    fontSize:   22.0,
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
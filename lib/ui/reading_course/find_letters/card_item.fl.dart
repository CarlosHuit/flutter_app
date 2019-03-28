import 'package:app19022019/core/src/viewmodels/reading_course/find_letters_view_model.dart';
import 'package:app19022019/utils/my_behavior.dart';
import 'package:flutter/material.dart';
import './item_letter_button.dart';



class CardItemFL extends StatefulWidget {

  final String               urlImg;
  final List<String>         letters;
  final String               correctLetter;
  final FindLettersViewModel viewModel;


  const CardItemFL({
    Key key,
    @required this.urlImg,
    @required this.letters,
    @required this.correctLetter,
    @required this.viewModel
  }) : super(key: key);

  @override
  _CardItemFLState createState() => _CardItemFLState();
}



class _CardItemFLState extends State<CardItemFL> {


  String get urlImg => widget.urlImg;
  String get correctLetter => widget.correctLetter;
  List<String> get letters => widget.letters;
  FindLettersViewModel get vm => widget.viewModel;


  double _intRadius;
  BoxDecoration _boxDecoration;
  BoxConstraints _boxConstraints;


  @override
  void initState() {

    super.initState();

    _intRadius = 25.0;

    _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(_intRadius),
      boxShadow:  [ BoxShadow( color: Colors.black54, blurRadius: 3.0 ) ],
      border:       Border.all( color: Colors.yellow[100], width: 4.0 ),
      color:        Colors.white,
    );

    _boxConstraints = BoxConstraints(
      maxHeight: 600.0,
      maxWidth:  380.0,
    );

  }


  @override
  Widget build(BuildContext context) {

    return Container(

      alignment: Alignment.center,

      child: Container(

        alignment:   Alignment.center,
        margin:      EdgeInsets.symmetric(vertical: 20.0),
        constraints: _boxConstraints,
        decoration:  _boxDecoration,

        child: Column(

          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            CardItemContent(
              correctLetter: correctLetter, vm: vm, letters: letters, urlImg: urlImg
            ),

            CardItemButtonHelp(
              onTap: vm.listenInstructions
            )

          ],

        ),

      ),

    );

  }


}



class CardItemContent extends StatelessWidget {

  final String               urlImg;
  final List<String>         letters;
  final String               correctLetter;
  final FindLettersViewModel vm;

  const CardItemContent({
    Key key,
    @required this.urlImg,
    @required this.letters,
    @required this.correctLetter,
    @required this.vm
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final intRadius = 25.0;

    return Expanded(

      child: Container(
        // color: Colors.red,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: Colors.red[100],
          // color: Colors.yellow[100],
          borderRadius: BorderRadius.only(
            topLeft:  Radius.circular(intRadius - 5),
            topRight: Radius.circular(intRadius - 5),
          ),
        ),

        padding: EdgeInsets.only(
          top:   10.0,
          left:  10.0,
          right: 10.0
        ),

        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(

            child: Column(
              
              mainAxisSize:       MainAxisSize.max,
              children: <Widget>[

                CardItemImage( urlImg: urlImg, onTap: vm.listenWord ),

                SizedBox(height: 15.0),

                CardItemListOptions(
                  ctx: context,
                  letters:  letters,
                  onSelect: vm.selectLetter,
                  correctLetter: correctLetter,
                ),

              ],
            ),


          ),
        ),

      ),

    );

  }


}



class CardItemListOptions extends StatefulWidget {

  final List<String> letters;
  final String correctLetter;
  final Function(String sel) onSelect;
  final BuildContext ctx;

  CardItemListOptions({
    Key key,
    @required this.letters,
    @required this.correctLetter,
    @required this.onSelect,
    @required this.ctx
  }) : super(key: key);

  @override
  _CardItemListOptionsState createState() => _CardItemListOptionsState();
}



class _CardItemListOptionsState extends State<CardItemListOptions> {

  List<String> get letters => widget.letters;
  String get correctLetter => widget.correctLetter;
  Function(String sel) get onSelect => widget.onSelect;
  Map<int, Size> btnSize;

  BuildContext get ctx => widget.ctx;
  double maxWidth;
  double maxCardWidth;

  @override
  void initState() {

    super.initState();

    maxWidth = 400.0;
    maxCardWidth = 380.0;

    final size = MediaQuery.of(ctx).size;

    final cardWidth = size.width < maxWidth
      ? (size.width * 0.95) - 40
      : maxCardWidth - 40;

    final btnWidth = (cardWidth  - (letters.length * 3)) / letters.length;

    btnSize = {
      1:  Size(50.0, 70.0),
      2:  Size(50.0, 70.0),
      3:  Size(50.0, 70.0),
      4:  Size(50.0, 70.0),
      5:  Size(50.0, 70.0),
      6:  Size(40.0, 70.0),
      7:  Size(35.0, 70.0),
      8:  Size(btnWidth, 70.0),
      9:  Size(btnWidth, 70.0),
      10: Size(btnWidth, 70.0),
    };


  }

  @override
  Widget build(BuildContext context) {


    return Container(

      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children:List.generate(
            widget.letters.length,
            (i) => ItemLetterButton(
              correctLetter: correctLetter,
              onSelect:   onSelect,
              letter:    letters[i],
              size: btnSize[letters.length],
            )
          )

        ),
      ),

    );


  }


}



class CardItemImage extends StatelessWidget {


  final Function() onTap;
  final String urlImg;

  const CardItemImage({ Key key, @required this.onTap, @required this.urlImg }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final maxWidth     = 400.0;
    final maxCardWidth = 380.0;
    final double width = MediaQuery.of(context).size.width;

    final circleSize = width < maxWidth
      ? width * 0.80
      : maxCardWidth * 0.80;

    final imgSize = circleSize * 0.5625;

    return Container(

      alignment: Alignment.center,
      height: circleSize,
      width:  circleSize,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150.0),
        color:        Color.fromARGB(255, 34, 34, 34),
        border:       Border.all(
          width: 5.0,
          color: Colors.deepOrange[400]
        ),
      ),

      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[


          Container(
            alignment: Alignment.center,
            width:  imgSize,
            height: imgSize,
            child:  Image(
              image: AssetImage(urlImg)
            ),
          ),


          Material(

            color:        Colors.transparent,
            borderRadius: BorderRadius.circular(150),

            child: InkWell(
              borderRadius:   BorderRadius.circular(150.0),
              highlightColor: Colors.transparent,
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(150.0) ),
              ),
            ),

          )


        ],
      ),

    );

  }


}



class CardItemButtonHelp extends StatelessWidget {

  final Function() onTap;

  const CardItemButtonHelp({Key key, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final intRadius = 25.0;

    return Container(
      height: 60.0,
      decoration: BoxDecoration(

        color: Colors.yellow[100],
        borderRadius: BorderRadius.only(
          bottomLeft:  Radius.circular(intRadius - 5.0),
          bottomRight: Radius.circular(intRadius - 5.0)
        ),

      ),
      child: Material(

        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.only(
            bottomLeft:  Radius.circular(intRadius - 5.0),
            bottomRight: Radius.circular(intRadius - 5.0)
          ),
          onTap:          onTap,
          splashColor:    Colors.orange[200],
          splashFactory:  InkRipple.splashFactory,
          highlightColor: Colors.transparent,

          child: Container(

            child: Row(
              mainAxisAlignment:  MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  'AYUDA',
                  style: TextStyle(
                    color:      Colors.blueGrey[800],
                    fontWeight: FontWeight.bold,
                    fontSize:   22.0,
                  ),
                ),

                SizedBox(width: 5.0),

                Icon(
                  Icons.volume_up,
                  color: Colors.blueGrey[800],
                  size:  28.0,
                )

              ],
            ),
          ),
        ),
      ),
    );

  }


}



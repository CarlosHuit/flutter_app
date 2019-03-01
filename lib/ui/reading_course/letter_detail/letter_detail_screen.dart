import 'package:flutter/material.dart';

class LetterDetailScreen extends StatefulWidget {
  @override
  _LetterDetailScreenState createState() => _LetterDetailScreenState();
}

class _LetterDetailScreenState extends State<LetterDetailScreen> {

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle( statusBarColor: Colors.transparent ));
    super.initState();
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle( statusBarColor: Colors.black12 ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    Offset _offset = Offset(0.4, 0.7); // new


    return Scaffold(
      appBar: AppBar(title: Text('data'),),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: size.width * .90,
          height: ((size.width * 0.90) / 3) * 4,
          color: Colors.green,
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(12, (i) {


              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // perspective
                  ..rotateX(_offset.dy)
                  ..rotateY(_offset.dx),
                alignment: FractionalOffset.center,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text('$i'),
                ),
              );

              // return Container(
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 2.0, color: Colors.white),
              //     gradient: LinearGradient(
              //       colors: [
              //         Colors.indigo[800],
              //         Colors.indigo[400],
              //       ],
              //       begin: Alignment.bottomRight,
              //       end:   Alignment.topLeft,
              //       stops: [0.1, 1.0]
              //     ),
              //   ),
              //   child: Text('$i', style: TextStyle(
              //     fontSize:   36.0,
              //     color:      Colors.white,
              //     fontWeight: FontWeight.bold
              //   )),
              // );
            }),
          ),
        ),



      )
    );

  }
}


import 'package:flutter/material.dart';

class OptionCardFront extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return Container(

      alignment: Alignment.center,
      child:     Icon( Icons.filter_vintage, color: Colors.white, size: 36.0 ),
      
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          begin:  Alignment.topRight,
          end:    Alignment.bottomLeft,
          stops: [0.1, 0.9],
          colors: [
            Color.fromARGB(255, 0, 155, 77),
            Color.fromARGB(255, 0, 172, 90),
          ],
        ),
      ),
 
    );

  }


}
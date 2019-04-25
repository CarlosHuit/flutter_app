import 'package:flutter/material.dart';

class StrokeColorSelector extends StatelessWidget {

  final List<Color> colors;
  final Color currentColor;
  final Function(Color color) onSelect;

  const StrokeColorSelector({
    Key key,
    @required this.colors,
    @required this.currentColor,
    @required this.onSelect
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final w =MediaQuery.of(context).size.width;

    return Card(
      elevation: 4.0,
      child: Container(
        constraints: BoxConstraints( maxWidth: w - 80.0 ),
        margin:      EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 10.0
        ),
        child: Wrap( children: generateColorList() ),
      ),
    );


  }

  List<Widget> generateColorList() {

    return List.generate(
      colors.length, (i) => GestureDetector(
        onTap: () => onSelect(colors[i]),
        child: Container(
          width:  35.0,
          height: 35.0,
          margin: EdgeInsets.symmetric(

            horizontal: 3.0,
            vertical: 3.0

          ),
          decoration: BoxDecoration(

            color:        colors[i],
            border:       Border.all(width: 0.8, color: Colors.grey[300]),
            borderRadius: BorderRadius.circular(50.0),

          ),
          child: colors[i] == currentColor
            ? Icon(
                Icons.done,
                color: Colors.white
              )
            : SizedBox(),
        ),

      )
    );

  }

}


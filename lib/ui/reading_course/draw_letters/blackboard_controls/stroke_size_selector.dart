import 'package:flutter/material.dart';

class StrokeSizeSelector extends StatefulWidget {

  final double value;
  final Function(double val) onChange;
  final double min;
  final double max;

  const StrokeSizeSelector({
    Key key,
    @required this.value,
    @required this.onChange,
    @required this.min,
    @required this.max
  }) : super(key: key);

  @override
  _StrokeSizeSelectorState createState() => _StrokeSizeSelectorState();
}



class _StrokeSizeSelectorState extends State<StrokeSizeSelector> {

  double get value => widget.value;
  Function(double val) get cb => widget.onChange;
  double get min => widget.min;
  double get max => widget.max;

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 0,
      margin: EdgeInsets.all(0),
      child: Container(
        height: 100.0,
        width: 220.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: <BoxShadow> [
            BoxShadow(color: Colors.black45, blurRadius: 10)
          ]
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Column(
          children: <Widget>[


            Container(
              height: 40.0,
              child: Slider(
                value: value,
                min: min,

                max: max,
                inactiveColor: Colors.blue[200],
                onChanged: cb,
                label: value.toString(),
                divisions: 12,
              ),
            ),


            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: value,
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            )


          ],
        ),
      ),
    );

  }
}



import 'package:app19022019/core/src/viewmodels/reading_course/draw_letters_view_model.dart';
import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:flutter/material.dart';

class BlackboardTopControlBar extends StatelessWidget {

  final DrawLettersViewModel vm;


  const BlackboardTopControlBar(this.vm, { Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return PositionedDirectional(
      start: 0,
      end:   0,
      top:   0,
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow> [
            BoxShadow(color: Colors.black45, blurRadius: 3.0)
          ]
        ),
        child: Row(
          children: <Widget>[


            /// FontSizeIcon
            CustomCircularIconButton(
              icon: Icon(Icons.create, size: 28.0),
              height: 50,
              width: 50,
              onTap: vm.toggleStrokeSizeSelector,
            ),


            /// ColorsSelectorIcon
            CustomCircularIconButton(
              icon: Icon(Icons.format_color_fill, size: 28.0,),
              height: 50,
              width: 50,
              onTap: vm.toggleStrokeColorSelector,
            ),


              /// ShowGuideLinesIcon
            CustomCircularIconButton(
              height: 50.0,
              width: 50.0,
              icon: Icon(
                vm.preferences.showGuideLines == true
                  ? Icons.visibility
                  : Icons.visibility_off,
                  size: 28.0,
              ),
              onTap: vm.toggleGuideLines,
            ),


          ],
        ),
      ),
      
    );

  }
}
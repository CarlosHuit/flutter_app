import 'package:app19022019/ui/components/custom_circular_icon_button.dart';
import 'package:flutter/material.dart';

class SystemDiscussion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.red[100],
            ),
          ),
          Container(
            color:       Colors.transparent,
            constraints: BoxConstraints( minHeight: 60.0 ),
            child: Row(
              children: <Widget>[


                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top:    8.0,
                      left:   15.0,
                      bottom: 8.0
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2.0
                          )
                        ]
                      ),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        // maxLength: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 60.0,
                  height: 60.0,
                  alignment: Alignment.center,
                  child: CustomCircularIconButton(
                    height: 48,
                    width:  48,
                    icon:   Icon(Icons.send),
                    onTap:  () {},
                    splashColor: Colors.red[100],
                  )
                )


              ],
            ),
          )
        ],
      ),
    );
  }

}
import 'dart:async';

import 'package:app19022019/core/src/viewmodels/reading_course/reading_course_view_model.dart';
import 'package:app19022019/ui/components/drawer/drawer.dart';
import 'package:app19022019/ui/reading_course/alphabet.dart';
import 'package:app19022019/ui/reading_course/learned_letters.dart';
import 'package:flutter/material.dart';

class ReadingCourseContent extends StatefulWidget {

  final ReadingCourseViewModel viewModel;

  const ReadingCourseContent({
    Key key, @required this.viewModel,
  }) : super(key: key);

  @override
  _ReadingCourseContentState createState() => _ReadingCourseContentState();
}

class _ReadingCourseContentState extends State<ReadingCourseContent> with SingleTickerProviderStateMixin {

  ReadingCourseViewModel get viewModel => widget.viewModel;
  TabController _tabController;

  bool iMsgPendingListening;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    iMsgPendingListening = true;
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(listenMsgOnChangeTab);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void didUpdateWidget(ReadingCourseContent oldWidget) {

    super.didUpdateWidget(oldWidget);

    if (viewModel.isLoading == false && iMsgPendingListening) {

      iMsgPendingListening = false;
      speakMessage(_tabController.index);

    }

  }

  listenMsgOnChangeTab() {

    final index = _tabController.index;

    if (_timer != null) {

      _timer.cancel();
    }

    setState(() {
      _timer = Timer(
        Duration(milliseconds: 600),
        () => speakMessage(index)
      );
    });

  }

  void speakMessage(int i) {

    if (i == 0) {
      viewModel.speakAlphabetMsg();
    } else {
      viewModel.speakLearnedLetterMsg();
    }

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:          readingCourseBar(),
      drawer:          MyDrawer(),
      backgroundColor: Colors.grey[100],
      body:            TabBarView(

        controller: _tabController,
        children: <Widget>[
          Alphabet(viewModel: viewModel),
          LearnedLetters(
            viewModel: viewModel
          )
        ],


      ),
      
    );
  }


  Widget readingCourseBar() {
    return AppBar(

      elevation: 3.0,
      title:     Text(
        'Weduc',
        style: TextStyle( fontFamily: 'Pacifico', fontSize: 26.0 ),
      ),
      centerTitle: true,

      bottom: TabBar(
        // onTap: speakMessage,
        indicatorColor:  Colors.red,
        indicatorWeight: 4.0,
        controller:      _tabController,
        tabs: <Widget>[
          TabAlphabet(),
          TabLearnedLetters()
        ],
      )
    );
  }


}
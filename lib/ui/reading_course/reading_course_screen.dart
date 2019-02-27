import 'package:app19022019/core/src/redux/reading_course/reading_course_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './alphabet.dart';
import './learned_letters.dart';
import 'package:app19022019/core/core.dart';

class ReadingCourseScreen extends StatefulWidget {
  @override
  _ReadingCourseScreenState createState() => _ReadingCourseScreenState();
}

class _ReadingCourseScreenState extends State<ReadingCourseScreen> with SingleTickerProviderStateMixin {

  TabController tabController;
  final SpeechSynthesisService tts = SpeechSynthesisService();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, ReadingCourseViewModel>(
      distinct: true,
      onInit:    (store) => store.dispatch( RCFetchInitialData() ),
      converter: (store) => ReadingCourseViewModel.fromStore(store: store),
      builder:   (BuildContext _, ReadingCourseViewModel viewModel) {

          print(viewModel.lettersMenu[0].imgUrl);

          return Scaffold(
            appBar: AppBar(

              elevation: 3.0,
              title:     Text(
                'Weduc',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize:   26.0
                ),
              ),
              centerTitle: true,

              bottom: TabBar(
                indicatorColor: Colors.red,
                indicatorWeight: 4.0,
                controller: tabController,
                tabs: <Widget>[
                  tabAlphabet(),
                  tabLearnedLetters()
                ],
              )
            ),

            drawer: Drawer( ),
            backgroundColor: Colors.grey[100],
            body: TabBarView(
              controller: tabController,
              children: <Widget>[
                alphabet(context, viewModel),
                learnedLetters(context, viewModel)
              ],
            ),
            
          );

      },
    );

  }



}


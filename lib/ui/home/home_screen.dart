import 'package:app19022019/core/core.dart';
import 'package:app19022019/ui/components/drawer/drawer.dart';
import 'package:app19022019/ui/components/loading_indicator.dart';
import 'package:app19022019/ui/home/home_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../utils/utils.dart';



class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();

}



class _HomeScreenState extends State<HomeScreen> {

  final OnBackPressed onBackPressed = OnBackPressed();
  AssetImage providerBackgroundDrawer;


  @override
  void initState() {
    providerBackgroundDrawer =AssetImage('assets/background-drawer.jpg');
    providerBackgroundDrawer.resolve(ImageConfiguration()).addListener((i, b) {});
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle( statusBarColor: Colors.black12 )
    );

    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, HomeViewModel>(

      distinct:  true,
      onInit:    (store) {

        final bool hasCourses = store.state.coursesState.courses.length > 0 ? true : false;
        if (hasCourses == false) {
          store.dispatch(FetchCourses());
        }

      },
      converter: (store) => HomeViewModel.fromStore(store: store),
      builder:   (BuildContext _, HomeViewModel viewModel) {

        return WillPopScope(
          onWillPop: () => onBackPressed.validation(context),
          child:     Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: homeAppBar(),
            drawer: MyDrawer(viewModel: viewModel,),
            body:  viewModel.courses.length > 0
              ? HomeScreenBody(viewModel: viewModel)
              : LoadingIndicator()

          ),
        );

      },
    );

  }

}



class HomeScreenBody extends StatelessWidget {

  final HomeViewModel viewModel;

  const HomeScreenBody({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:   Column(
          children: <Widget>[
            SearchInput(),
            CoursesList(viewModel: viewModel,)

          ],
        ),
      )

    );
  }

}



class CoursesList extends StatelessWidget {

  final HomeViewModel viewModel;

  const CoursesList({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap:  true,
      physics:     BouncingScrollPhysics(),
      itemCount:   viewModel.courses.length,
      itemBuilder: (_, index) => CourseCard(course: viewModel.courses[index], vm: viewModel),
    );
  }
}



class CourseCard extends StatelessWidget {

  final Course course;
  final HomeViewModel vm;

  const CourseCard({Key key, this.course, this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
        child:InkWell(
          onTap: () => vm.setCurrentCourse(course),
          child: Row(
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                padding: EdgeInsets.all(8.0),
                child:     Image.asset(
                  'assets/${course.title.toLowerCase()}-min.png',
                  height: 65.0,
                  width: 65.0
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    '${course.title}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:   28.0,
                      fontFamily: 'Roboto'
                    ),
                  ),
                ),
              )
            ],
          ),

        )
      ),
    );
  }

}



class SearchInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(

      margin:    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      padding:   EdgeInsets.only(left: 15.0),
      alignment: Alignment.bottomCenter,

      decoration: BoxDecoration(
        color:        Colors.white,
        border:       Border.all( width: 1.5, color: Colors.grey[300] ),
        borderRadius: BorderRadius.all( Radius.circular(4.0) )
      ),

      child:   TextField(
        onSubmitted: (term) => term,
        onChanged:   (term) => term,
        style:       TextStyle(fontSize: 16.0, color: Colors.black),
        decoration:  InputDecoration(

          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
          hintText:   '¿Qué quieres aprender hoy?',
          border:     InputBorder.none,
          hintStyle:  TextStyle(color: Colors.black45, fontSize: 18.0),
          suffixIcon: Icon(Icons.search, color: Colors.black45, size: 28.0),

        ),
      ),

    );
  }


}
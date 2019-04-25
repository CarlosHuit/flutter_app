import 'package:app19022019/core/src/viewmodels/reading_course/find_letters_view_model.dart';
import 'package:app19022019/ui/components/well_done_dialog_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './card_item.fl.dart';

class FIndLettersContent extends StatefulWidget {

  final FindLettersViewModel viewModel;

  FIndLettersContent({ Key key, this.viewModel }) : super(key: key);

  @override
  _FIndLettersContentState createState() => _FIndLettersContentState();

}

class _FIndLettersContentState extends State<FIndLettersContent> {

  FindLettersViewModel get vm => widget.viewModel;

  SwiperController controller;

  @override
  void initState() {

    super.initState();
    controller = SwiperController();
    vm.listenInstructions();
  }

  @override
  void didUpdateWidget(FIndLettersContent oldWidget) {

    super.didUpdateWidget(oldWidget);


    if (vm.currentData.pendings == 0) {
      Future.delayed(Duration(milliseconds: 1300), nextPage);
    }

  }

  @override
  void dispose() {

    controller.dispose();
    super.dispose();

  }


  void nextPage() {

    if (vm.currentIndex < vm.data.length - 1) {

      vm.changeCurrentData();
      controller.next();

    } else {

      vm.showWellDoneDialogApp();
      // vm.redirection();

    }

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: Colors.grey[10],

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit:   BoxFit.cover,
            image: AssetImage("assets/star-pattern.png"),
          ),
          gradient: LinearGradient(
            stops:    [0.0, 0.8],
            // end: Alignment.topCenter,
            // begin:   Alignment.bottomCenter,
            begin: Alignment.topCenter,
            end:   Alignment.bottomCenter,
            // begin: Alignment.bottomLeft,
            // end:   Alignment.topRight,
            colors: [
              Color.fromARGB(255, 11, 62, 113),
              Color.fromARGB(255, 13, 100, 176)
            ]
          )
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[

            Swiper(
              
              outer:      true,
              scale:      0.85,
              controller: controller,
              curve:      Curves.easeIn,
              duration:   450,
              itemCount:  vm.data.length,
              physics:    NeverScrollableScrollPhysics(),
              viewportFraction: 0.95,
              onIndexChanged:   (i) => vm.listenInstructions(),

              pagination:  SwiperPagination(
                alignment: Alignment.topCenter,
                builder:   SwiperPagination.dots,
                margin:    EdgeInsets.only(bottom: 10.0)
              ),

              itemBuilder: (_, index) {

                return CardItemFL(
                  letters:       vm.data[index].letters,
                  urlImg:        vm.data[index].imgUrl,
                  correctLetter: vm.data[index].letter,
                  viewModel:     vm,
                );

              }

            ),

            vm.showSuccessDialog
              ? WellDoneDialogApp(
                onEnd: () {
                  vm.hideWellDoneDialogApp();
                  vm.redirection();
                },
                onStart: vm.speakWellDone,
              )
              : Offstage()


          ],
        ),
      ),

    );


  }
}



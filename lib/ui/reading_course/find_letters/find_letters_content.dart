import 'package:app19022019/core/src/viewmodels/reading_course/find_letters_view_model.dart';
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

      vm.redirection();

    }

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: Colors.red,
      body: Swiper(
        
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
          margin:    EdgeInsets.only(bottom: 5.0)
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

    );


  }
}



import 'package:app19022019/core/src/viewmodels/reading_course/find_letters_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './card_item.fl.dart';

class SwipperCards extends StatefulWidget {

  final FindLettersViewModel viewModel;

  SwipperCards({ Key key, this.viewModel }) : super(key: key);

  @override
  _SwipperCardsState createState() => _SwipperCardsState();

}

class _SwipperCardsState extends State<SwipperCards> {

  FindLettersViewModel get vm => widget.viewModel;

  SwiperController controller;

  @override
  void initState() {

    super.initState();
    controller = SwiperController();
    vm.listenInstructions();
  }

  @override
  void didUpdateWidget(SwipperCards oldWidget) {

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
        onIndexChanged: (i) => vm.listenInstructions(),
        controller: controller,
        itemCount:  vm.data.length,
        physics:    NeverScrollableScrollPhysics(),
        viewportFraction: 0.95,

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



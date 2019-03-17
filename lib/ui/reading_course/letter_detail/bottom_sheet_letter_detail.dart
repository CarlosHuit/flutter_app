  import 'dart:async';

import 'package:app19022019/core/src/viewmodels/reading_course/letter_detail_view_model.dart';
import 'package:app19022019/ui/reading_course/letter_detail/letter_modal.dart';
import 'package:flutter/material.dart';

void showModalSheet(LetterDetailViewModel vm, BuildContext context) async {


    await Future.delayed(Duration(milliseconds: 500));
    vm.modalSheetIMsg();

    showModalBottomSheet(

      context: context,
      builder: (_) => LetterModal(letter: vm.data.letter)

    ).whenComplete(() {
      vm.modalSheetFMsg();
      vm.dispatchShowAllCards();
      Future.delayed(Duration(milliseconds: 3000), vm.dispatchHideAllCards);
    });

  }
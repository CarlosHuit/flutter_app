import 'package:app19022019/core/src/models/course_model.dart';
import 'package:app19022019/core/src/redux/app/app_state.dart';
import 'package:app19022019/core/src/redux/discussion_system/discussion_system_actions.dart';
import 'package:app19022019/core/src/viewmodels/discussion_system_view_model.dart';
import 'package:app19022019/ui/discussion_system/comment_thread_component.dart';
import 'package:app19022019/ui/discussion_system/text_field_write_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DiscussionSystemComponent extends StatefulWidget {

  final Course course;

  const DiscussionSystemComponent({
    Key key,
    @required this.course
  }) : super(key: key);

  @override
  _DiscussionSystemComponentState createState() => _DiscussionSystemComponentState();
}

class _DiscussionSystemComponentState extends State<DiscussionSystemComponent> {


  Course get course => widget.course;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, DiscussionSystemViewModel>(
      distinct:  true,
      converter: (store) => DiscussionSystemViewModel.fromStore(store),
      onInit:    (store) => store.dispatch(DSGetCourseComments(course)),
      builder:   (_, vm) {


        return Container(

          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                SizedBox(height: 5.0),
                TextFieldWriteComment( onSubmit: vm.addComment ),
                buildContent(vm),

              ],
            ),
          ),

        );


      },


    );


  }

  Widget buildContent(DiscussionSystemViewModel vm) {

    final hasComments = !vm.isLoadingComments && vm.comments.length > 0;
    final notHasComments = !vm.isLoadingComments && vm.comments.length == 0;


    if (vm.isLoadingComments) {

      return Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: CircularProgressIndicator(),
      );

    }


    if (hasComments) {

      final threadsComments = List.generate(
        vm.comments.length,
        (i) {

          final comment = vm.comments[i];

          return CommentThreadComponent(
            data: comment,
            viewModel: vm,
          );

        }
      );

      return SingleChildScrollView(
        child: Column(
          children: threadsComments
        ),
      );

    }

    if (notHasComments) {

      return Container(
        constraints: BoxConstraints( maxWidth: 320.0 ),
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          'Sé el primero en comentar.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight:  FontWeight.bold,
            fontSize:  18.0,
            color:   Colors.grey,
          ),
        ),
      );

    }

    return Container(
      constraints: BoxConstraints( maxWidth: 320.0 ),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        'Ha ocurrido un error. Inténtalo nuevamente más tarde.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color:      Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize:   18.0
        ),
      ),
    );

  }


}





import 'package:Posts_App/features/posts/domain/entities/post.dart';
import 'package:Posts_App/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:Posts_App/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_event.dart';
import 'package:Posts_App/features/posts/presentation/widegts/add_upade_page/text_form_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdatePost;
  const FormWidget({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void validateFormThenUpdateOrAdd() {
    final isValid = _formKey.currentState!.validate();

    final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text);
    if (isValid) {
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFiledWidget (
                name : 'Title' ,
                multiLines: false,
                controller : _titleController
              ),
            TextFormFiledWidget (
                name : 'Body' ,
                multiLines: true,
                controller : _bodyController,
            ),
            ElevatedButton.icon(
              onPressed:validateFormThenUpdateOrAdd,
              icon: widget.isUpdatePost
                  ? const Icon(Icons.edit)
                  : const Icon(Icons.add),
              label: Text(widget.isUpdatePost ? "Update" : "Add"),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_state.dart';
import '../../pages/posts_page.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtn extends StatelessWidget {
  final int postId;
  const DeletePostBtn({Key? key, required this.postId, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(onPressed: ()=> deleteDialog(context,postId),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
      icon: const Icon(Icons.delete_outline),
      label: const Text('Delete'),
    );
  }

  void deleteDialog(BuildContext context, int postId  ) {
    showDialog(context: context, builder: (context) {
      return BlocConsumer<AddDeleteUpdatePostBloc,AddDeleteUpdatePostState>(
        listener: (context, state) {
          if(state is MessageAddDeleteUpdatePostState) {
            SnackBarMessage().shoeSuccessSnackBar(message: state.message, context: context);

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) =>
                const PostsPage()),
                    (route) => false );
          } else if (state is ErrorAddDeleteUpdatePostState){
            Navigator.of(context).pop();
            SnackBarMessage().shoeErrorSnackBar(message: state.message, context: context);
          }
        },
        builder: (context , state) {
          if (state is LoadingAddDeleteUpdatePostState){
            return const AlertDialog(
              title: LoadingWidget(),
            );
          }
          return  DeleteDialogWidget(postId: postId);
        },
      );
    });
  }
}

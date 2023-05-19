import 'package:Posts_App/core/utils/snackbar_message.dart';
import 'package:Posts_App/core/widgets/loading_widget.dart';
import 'package:Posts_App/features/posts/domain/entities/post.dart';
import 'package:Posts_App/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:Posts_App/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_delete_update_post/add_delete_update_post_state.dart';
import '../widegts/add_upade_page/from_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdated;
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body:  _buildBody(),
    );
  }

  AppBar _buildAppBar () {
   return AppBar(title:Text(isUpdated ? "Edit Post " : "Add Post"),
    );
  }

  Widget _buildBody () {
      return Center(
        child: Padding
          (padding:const  EdgeInsets.all(10),
          child: BlocConsumer<AddDeleteUpdatePostBloc,AddDeleteUpdatePostState>(
            builder: (context,state) {
               if(state is LoadingAddDeleteUpdatePostState){
                 return const LoadingWidget();
               }
               return FormWidget(isUpdatePost: isUpdated, post: isUpdated ? post : null,);
            },
            listener:(context , state){
              if(state is MessageAddDeleteUpdatePostState){
                SnackBarMessage().shoeSuccessSnackBar(message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const PostsPage()), (route) => false);
              }else if (state is ErrorAddDeleteUpdatePostState){
                SnackBarMessage().shoeErrorSnackBar(message: state.message, context: context);
              }
            },
          ),
        ),
      );
  }
}

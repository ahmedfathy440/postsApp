import 'package:Posts_App/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:Posts_App/features/posts/presentation/bloc/posts/posts_state.dart';
import 'package:Posts_App/features/posts/presentation/pages/post_add_upate_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/posts/posts_event.dart';
import '../widegts/pages_page/message_display_widget.dart';
import '../widegts/pages_page/posts_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionBtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text('Posts'),
      );

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: PostListWidget(posts: state.posts),
          );
        } else if (state is ErrorPostsState) {
          return MessageDisplayWidget(message: state.message);
        }
        return const LoadingWidget();
      }),
    );
  }

  _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPosts());
  }

  Widget _buildFloatingActionBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const PostAddUpdatePage(isUpdated: false)));
      },
      child: const Icon(Icons.add),
    );
  }
}

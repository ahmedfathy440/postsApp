import 'package:Posts_App/features/posts/domain/entities/post.dart';
import 'package:Posts_App/features/posts/presentation/pages/post_add_upate_page.dart';
import 'package:flutter/material.dart';
import '../widegts/detail_page/deletePostBtn.dart';
import '../widegts/detail_page/update_post_btn.dart';

class DetailPage extends StatelessWidget {
  final Post post;
  const DetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 50,
            ),
            Text(
              post.body,
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UpdatePostBtn(post: post),
                DeletePostBtn(postId :post.id!),
              ],
            )
          ],
        ),
      ),
    );
  }


}

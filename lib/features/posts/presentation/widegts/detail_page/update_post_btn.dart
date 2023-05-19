import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';
import '../../pages/post_add_upate_page.dart';

class UpdatePostBtn extends StatelessWidget {
  final Post post;
  const UpdatePostBtn({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    PostAddUpdatePage(isUpdated: true,post: post)));
      },
      icon: const Icon(Icons.edit),
      label: const Text('Edit'),
    );
  }
}

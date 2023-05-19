import 'package:flutter/material.dart';

class TextFormFiledWidget extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final bool multiLines;
  const TextFormFiledWidget(
      {Key? key,
      required this.controller,
      required this.name,
      required this.multiLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "$name Can't by empty" : null,
        decoration:  InputDecoration(
          hintText: name,
        ),
        maxLines: multiLines?6:1,
        minLines: multiLines?6:1,
      ),
    );
  }
}

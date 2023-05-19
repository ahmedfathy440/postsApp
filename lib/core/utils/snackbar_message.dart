import 'package:flutter/material.dart';

class SnackBarMessage {

  void shoeSuccessSnackBar ({required String message , required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text (message,style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
      ),
    );
  }

  void shoeErrorSnackBar ({required String message , required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text (message,style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

}
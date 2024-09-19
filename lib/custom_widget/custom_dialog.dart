import 'package:flutter/material.dart';

class CustomDialoge extends StatelessWidget {
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;
  final String title;
  final String content;
  const CustomDialoge({
    Key? key,
    required this.onYesPressed,
    required this.onNoPressed,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(title,style: const TextStyle(color: Colors.black),),
      content: Text(content,style: const TextStyle(color: Colors.black),),
      actions: <Widget>[
        TextButton(
          onPressed: onNoPressed,
          child:const Text('No',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: onYesPressed,
          child:const Text('Yes',style: TextStyle(color: Colors.black),),
        ),
      ],
    );
  }
}


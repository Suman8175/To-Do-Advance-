import 'package:flutter/material.dart';

class Message {
  final String title;
  final String msg;
  final String buttontext;
  final void Function() onTrue;
  const Message(
      {required this.title,
      required this.msg,
      required this.buttontext,
      required this.onTrue});

  Future<void> onPressed(BuildContext context) async {
    return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: onTrue,
              child: Text(
                buttontext,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      }),
    );
  }
}

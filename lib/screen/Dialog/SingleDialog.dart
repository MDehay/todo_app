import 'package:flutter/material.dart';

class SingleDialog extends StatelessWidget {
  const SingleDialog(
      {Key? key,
      required this.title,
      required this.content,
      this.textOKButton = "Valider",
      this.textCancelButton = "Annuler",
      required this.callbackOK,
      required this.callbackCancel})
      : super(key: key);

  final Widget content;

  final String title;
  final String textOKButton;
  final String textCancelButton;

  final Function callbackOK;
  final Function callbackCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        ElevatedButton(
          onPressed: () {
            callbackOK();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text(textOKButton),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            callbackCancel();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: Text(textCancelButton),
        ),
      ],
    );
  }
}

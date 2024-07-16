import 'package:flutter/material.dart';

class CustomDialogWidget extends StatefulWidget {
  final String message;
  final VoidCallback onConfirm;

  CustomDialogWidget({required this.message, required this.onConfirm});

  @override
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text(widget.message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: widget.onConfirm,
          child: Text('Confirm'),
        ),
      ],
    );
  }
}

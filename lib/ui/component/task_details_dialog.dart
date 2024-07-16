import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database_manager/model/task.dart';

class TaskDetailsDialog extends StatelessWidget {
  final Task task;

  TaskDetailsDialog({required this.task});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(
        textAlign: TextAlign.center,
        'Task Details',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            textAlign: TextAlign.start,
            'Title: ${task.title}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            'Description: ${task.description}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            'Date Time: ${DateFormat.yMMMd().format(task.dateTime!.toDate())}',
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff5D9CEC)),
            // foregroundColor:
            // MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

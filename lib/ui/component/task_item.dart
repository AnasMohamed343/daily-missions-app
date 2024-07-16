import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_missions_app/database_manager/model/task.dart';
import 'package:daily_missions_app/database_manager/tasks_dao.dart';
import 'package:daily_missions_app/providers/authentication_provider.dart';
import 'package:daily_missions_app/ui/component/task_details_dialog.dart';
import 'package:daily_missions_app/utils/dialog_utils.dart';
import 'package:daily_missions_app/utils/dialog_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/dialog_utils.dart';
import 'cutom_text_form-field.dart';

class TaskItem extends StatefulWidget {
  Task task;
  GlobalKey<ScaffoldState> scaffoldKey;
  TaskItem({required this.task, required this.scaffoldKey});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  List<Task> _deletedTasks = [];
  bool _isMounted = true;
  //final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => TaskDetailsDialog(task: widget.task),
        );
      },
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .3, //the size or the width
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                removeTask(widget.task);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
            extentRatio: .3, //the size or the width
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  _showEditTaskBottomSheet(context, widget.task);
                },
                backgroundColor: Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ]),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          margin: EdgeInsets.all(15),
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 62,
                decoration: BoxDecoration(
                  color: Color(0xff5D9CEC),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        // AppLocalizations.of(context)!.taskTitle,
                        // style: TextStyle(
                        //   color: Color(0xff5D9CEC),
                        //   fontSize: 23,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        widget.task.title ?? ''),
                    // Text(
                    //     // '10:30 AM',
                    //     // style: Theme.of(context).textTheme.displaySmall,
                    //     task.description ?? ''),
                    Text(
                      DateFormat.yMMMd().format(widget.task.dateTime!.toDate()),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
              //Spacer(),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                      color: Color(0xff5D9CEC),
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 28,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void removeTask(Task task) {
    DialogUtils.showMessage(
      context,
      'Are u Sure u  Want To Delete This Task?',
      posActionTitle: 'Confirm',
      negActionTitle: 'Cancel',
      posAction: () {
        deleteTask(task);
      },
    );
  }

  Future<void> deleteTask(Task task) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    // Mark the task as deleted
    //task.deleted = true;
    // Store the deleted task in a separate list
    _deletedTasks.add(task);
    // Update the task in the database
    //await TasksDao.updateTaskInDb(authProvider.dbUser!.id!, task);

    // //DialogUtils.showLoadingDialog(context, 'Deleting Task...');
    await TasksDao.deleteTaskFromDb(authProvider.dbUser!.id!, task.id!);
    if (_isMounted) {
      DialogUtils.showMessage(
        widget.scaffoldKey.currentContext!, // Use the GlobalKey here
        'Task Deleted Successfully',
        posActionTitle: 'OK',
        negActionTitle: 'Undo',
        negAction: () {
          _undoDeleteTask(task);
        },
      );
    }
  }

  void _undoDeleteTask(Task task) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    // Remove the task from the deleted tasks list
    _deletedTasks.remove(task);

    // Restore the task in the database
    await TasksDao.addTask(task, authProvider.dbUser!.id!);

    // Update the task in the database
    //TasksDao.updateTaskInDb(authProvider.dbUser!.id!, task);

    // Show a success message
    DialogUtils.showMessage(
      context,
      'Task restored successfully',
      posActionTitle: 'oK',
    );
  }

  void _showEditTaskBottomSheet(BuildContext context, Task task) {
    var titleController = TextEditingController(text: task.title);
    var detailsController = TextEditingController(text: task.description);
    DateTime? _selectedDate = task.dateTime!.toDate();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            top: 16,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.editTask,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                CustomTextFormField(
                  controller: titleController,
                  labelText: AppLocalizations.of(context)!.taskTitle,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Enter Task Title';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: detailsController,
                  labelText: AppLocalizations.of(context)!.taskDetails,
                  maxLines: 4,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Enter Task Details';
                    }
                    return null;
                  },
                ),
                InkWell(
                  onTap: () {
                    _showDatePicker(context).then((value) {
                      if (value != null) {
                        setState(() {
                          _selectedDate = value;
                        });
                      }
                    });
                  },
                  child: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : '${formatDate(_selectedDate!, [
                                yyyy,
                                '/',
                                mm,
                                '/',
                                dd
                              ])}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                Visibility(
                  visible: _selectedDate == null,
                  child: Text(
                    'Plz, Select Date',
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff5D9CEC)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    _editTask(task, titleController.text,
                        detailsController.text, _selectedDate);
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.saveChanges,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 7)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    return date;
  }

  void _editTask(Task task, String newTitle, String newDescription,
      DateTime? newDate) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    task.title = newTitle;
    task.description = newDescription;
    task.dateTime =
        Timestamp.fromMillisecondsSinceEpoch(newDate!.millisecondsSinceEpoch);

    try {
      DialogUtils.showLoadingDialog(context, 'Saving changes...');
      await TasksDao.updateTaskInDb(authProvider.dbUser!.id!, task);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
        context,
        'Task updated successfully',
        posActionTitle: 'oK',
        // posAction: () => Navigator.pop(context),
      );
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Something went wrong, ${e.toString()}',
          posActionTitle: 'Try Again');
    }
  }
}

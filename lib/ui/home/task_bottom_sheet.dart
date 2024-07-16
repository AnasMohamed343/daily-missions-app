import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_missions_app/database_manager/model/task.dart';
import 'package:daily_missions_app/database_manager/tasks_dao.dart';
import 'package:daily_missions_app/providers/authentication_provider.dart';
import 'package:daily_missions_app/ui/component/custom_button.dart';
import 'package:daily_missions_app/ui/component/cutom_text_form-field.dart';
import 'package:daily_missions_app/utils/dialog_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<
      FormState>(); // to make reference on the formState, to can access the validate function from the formState, and to be can use it outside  the build.

  var titleController = TextEditingController();
  var detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 16,
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.addNewTask,
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
                  showTaskDatePicker();
                },
                child: Text(
                  finalSelectedDate == null ? 'Select Date' : '${fDate}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Visibility(
                visible: showDateError,
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
                  addTask();
                },
                child: Text(
                  AppLocalizations.of(context)!.addTask,
                ),
              ),
              // CustomButton(
              //     buttonText: AppLocalizations.of(context)!.addTask,
              //     onButtonClickedCallBack: () {}),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidForm() {
    bool isValid = true;
    if (formKey.currentState?.validate() == false) {
      isValid = false;
    }
    if (finalSelectedDate == null) {
      setState(() {
        showDateError = true;
      });
      isValid = false;
    }
    return isValid;
  }

  addTask() async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    if (!isValidForm()) {
      return;
    }
    // add task to fireStore
    Task task = Task(
      title: titleController.text,
      description: detailsController.text,
      dateTime: Timestamp.fromMillisecondsSinceEpoch(
          finalSelectedDate!.millisecondsSinceEpoch),
    );
    try {
      DialogUtils.showLoadingDialog(context, 'Loading...');
      await TasksDao.addTask(task, authProvider.dbUser!.id!);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
        context,
        'Task Added Successfully',
        posActionTitle: 'oK',
        posAction: () => Navigator.pop(context),
      );
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Something Went Wrong, ${e.toString()}',
          posActionTitle: 'Try Again');
    }
  }

  String get fDate => formatDate(finalSelectedDate!, [yyyy, '/', mm, '/', dd]);
  DateTime? finalSelectedDate;
  bool showDateError = false;
  void showTaskDatePicker() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (date != null) {
      finalSelectedDate = date;
      showDateError = false;
      setState(() {});
    }
  }
}

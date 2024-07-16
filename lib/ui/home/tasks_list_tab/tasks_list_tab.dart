import 'package:daily_missions_app/database_manager/tasks_dao.dart';
import 'package:daily_missions_app/providers/authentication_provider.dart';
import 'package:daily_missions_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../component/horizontal_week_calendar.dart';
import '../../component/task_item.dart';

class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  var selectedDate = DateTime.now();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthenticationProvider>(context);
    return Column(
      key: scaffoldKey,
      children: [
        HorizontalWeekCalendar(
          minDate: DateTime.now().subtract(Duration(days: 7)),
          maxDate: DateTime.now().add(Duration(days: 365)),
          initialDate: DateTime.now(),
          onDateChange: (datetime) {
            selectedDate = datetime;
            setState(() {});
          },
        ),
        StreamBuilder(
          stream: TasksDao.getTasksRealTimeUpdates(
              authProvider.dbUser!.id!, selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text('Somthing Went Wrong'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
            var tasksList = snapshot.data;
            return Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => TaskItem(
                task: tasksList![index],
                scaffoldKey: scaffoldKey,
              ),
              itemCount: tasksList?.length ?? 0,
            ));
          },
        )
      ],
    );
  }
}

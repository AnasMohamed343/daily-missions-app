import 'package:daily_missions_app/ui/auth/login/login_screen.dart';
import 'package:daily_missions_app/ui/home/settings_tab/settings_tab.dart';
import 'package:daily_missions_app/ui/home/task_bottom_sheet.dart';
import 'package:daily_missions_app/ui/home/tasks_list_tab/tasks_list_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  String appBarTitle = 'Tasks Tab';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(appBarTitle), //AppLocalizations.of(context)!.appTitle
            Spacer(),
            IconButton(
                onPressed: () {
                  signOut();
                },
                icon: Icon(Icons.logout)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(color: Theme.of(context).cardColor, width: 5),
        ),
        // RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(80),
        //   side: BorderSide(width: 4, color: Colors.white),
        // ),
        backgroundColor: Color(0xff5D9CEC),
        onPressed: () {
          addTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Wrap(
          //i raped (BottomNavigationBar) with widget (Wrap) before raping it with (BottomAppBar), to avoid the error[A RenderFlex overflowed by 8.0 pixels on the bottom.]
          children: [
            BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: selectedIndex,
                onTap: (index) {
                  selectedIndex = index;
                  if (index == 0) {
                    appBarTitle = 'Tasks Tab';
                  } else {
                    appBarTitle = 'Settings Tab';
                  }
                  setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      label: AppLocalizations.of(context)!.tasksTab),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: AppLocalizations.of(context)!.settingsTab),
                ]),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [TasksListTab(), SettingsTab()];

  void addTaskBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}

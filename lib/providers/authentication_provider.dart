import 'package:daily_missions_app/database_manager/model/user.dart' as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database_manager/user_dao.dart';

class AuthenticationProvider extends ChangeNotifier {
  MyUser.User? dbUser;
  User? firebaseAuthUser;

  Future<void> register(
      String email, String password, String userName, String fullName) async {
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    MyUser.User user = MyUser.User(
      id: credential.user!
          .uid, // here i made the id for the user be the same id in authentication
      userName: userName,
      fullName: fullName,
      emailAddress: email,
    );
    await UserDao.addUser(user);
  }

  Future<void> login(String email, String password) async {
    var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    dbUser = await UserDao.getUser(credential.user!.uid);
    firebaseAuthUser = credential.user;
  }
}

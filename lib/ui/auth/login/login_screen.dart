import 'dart:io';

import 'package:daily_missions_app/database_manager/user_dao.dart';
import 'package:daily_missions_app/providers/authentication_provider.dart';
import 'package:daily_missions_app/ui/auth/register/register_screen.dart';
import 'package:daily_missions_app/ui/component/custom_button.dart';
import 'package:daily_missions_app/ui/home/home_screen.dart';
import 'package:daily_missions_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/firebase_error_codes.dart';
import '../../../utils/email_validation.dart';
import '../../component/cutom_text_form-field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'anas@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg_login&rig.png'))),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.login,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: emailController,
                  labelText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      //must make this condition(input == null) first because, the object(input) is nullable
                      return 'Plz,,, Enter e-mail address';
                    }
                    if (!isValidEmail(input)) {
                      return 'E-mail bad format';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: passwordController,
                  labelText: AppLocalizations.of(context)!.password,
                  keyboardType: TextInputType.visiblePassword,
                  isObscureText: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      //must make this condition(input == null) first because, the object(input) is nullable
                      return 'Plz,,, Enter password';
                    }
                    if (input.length < 6) {
                      return 'Password must be at least 6 chars';
                    }
                    return null; // by default returns null
                  },
                ),
                // CustomButton(
                //   buttonText: 'Sign-In',
                //   onButtonClickedCallBack: signIn,
                // )
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff5D9CEC)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      signIn();
                    },
                    child: Text(AppLocalizations.of(context)!.signIn)),
                TextButton(
                    style: ButtonStyle(
                      alignment: Alignment.bottomLeft,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RegisterScreen.routeName);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.goToRegisterPage,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    var authProvider = Provider.of<AuthenticationProvider>(context,
        listen:
            false); // listen: false , why? => because i called the obj provider outside the (build).
    //form validation
    if (!(formKey.currentState!.validate())) {
      return;
    }
    try {
      DialogUtils.showLoadingDialog(
        context,
        'Loading...',
        isDismissable: false,
      );
      await authProvider.login(emailController.text, passwordController.text);
      //print(user?.userName);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Login Successfully',
          posActionTitle: 'oK', posAction: () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      });
      //print(result.user?.uid);
      //Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == FirebaseErrorCodes.userNotFound ||
          e.code == FirebaseErrorCodes.wrongPassword) {
        DialogUtils.showMessage(
          context,
          'wrong email or password',
          posActionTitle: 'Try Again',
        );
      }
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
        context,
        e.toString(),
        posActionTitle: 'Try Again',
      );
    }
  }
}

import 'package:daily_missions_app/core/firebase_error_codes.dart';
import 'package:daily_missions_app/database_manager/model/user.dart'
    as MyUser; // because there is two classes with name (User)
import 'package:daily_missions_app/database_manager/user_dao.dart';
import 'package:daily_missions_app/providers/authentication_provider.dart';
import 'package:daily_missions_app/ui/auth/login/login_screen.dart';
import 'package:daily_missions_app/ui/component/custom_button.dart';
import 'package:daily_missions_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../utils/email_validation.dart';
import '../../component/cutom_text_form-field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

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
            AppLocalizations.of(context)!.register,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(top: 80, right: 5, left: 5, bottom: 75
                  //MediaQuery.of(context).viewInsets.bottom,
                  ),
              child: SingleChildScrollView(
                // keyboardDismissBehavior:
                //     ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: fullNameController,
                      labelText: AppLocalizations.of(context)!.fullName,
                      keyboardType: TextInputType.text,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Plz,,, Enter Full Name';
                        }
                        if (input.length < 6) {
                          return 'Error, full name must be at least 6 chars';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      controller: userNameController,
                      labelText: AppLocalizations.of(context)!.userName,
                      keyboardType: TextInputType.text,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Plz,,, Enter User Name';
                        }
                        // if(input.length > 10){
                        //   return 'Error, user name cannot be more than 10 chars';
                        // }
                        return null;
                      },
                    ),
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
                    CustomTextFormField(
                      controller: confirmPasswordController,
                      labelText: AppLocalizations.of(context)!.confirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      isObscureText: true,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          //must make this condition(input == null) first because, the object(input) is nullable
                          return 'Plz,,, Enter password';
                        }
                        if (input != passwordController.text) {
                          return 'Password not match';
                        }
                        return null; // by default returns null
                      },
                    ),
                    // CustomButton(
                    //   buttonText: 'Sign-Up',
                    //   onButtonClickedCallBack: signUp,
                    // )
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff5D9CEC)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          signUp();
                        },
                        child: Text(AppLocalizations.of(context)!.signUp)),
                    TextButton(
                        style: ButtonStyle(
                          alignment: Alignment.bottomLeft,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.goToLoginPage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    //form validation
    if (!(formKey.currentState!.validate())) {
      return;
    }
    // now you can create user
    try {
      DialogUtils.showLoadingDialog(
        context,
        'Loading...',
        isDismissable: false,
      );

      await authProvider.register(emailController.text, passwordController.text,
          userNameController.text, fullNameController.text);

      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'User Registered Successfully',
          posActionTitle: 'oK', posAction: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      });
      // print(result.user?.uid);
      // Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == FirebaseErrorCodes.weakPassword) {
        DialogUtils.showMessage(context, 'The password provided is too weak.',
            posActionTitle: 'Try Again');
      } else if (e.code == FirebaseErrorCodes.emailInUse) {
        DialogUtils.showMessage(
            context, 'The account already exists for that email.',
            posActionTitle: 'Try Again');
      }
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, e.toString(),
          posActionTitle: 'Try Again');
    }
  }
}

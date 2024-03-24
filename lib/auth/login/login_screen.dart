import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_2/components/custom_text_form_field.dart';
import 'package:todo_app_2/dialog_utils.dart';
import 'package:todo_app_2/firebase_utilities.dart';

import '../../home/home_screen.dart';
import '../../provider/auth_provider.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var passwordController = TextEditingController(text: '12345678');

  var emailController = TextEditingController(text: 'fahd@l555.com');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    CustomTextFormField(
                      label: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Email';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'Please Enter a Valid Email';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Password';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (text.length < 6) {
                          return 'Password Should be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15)),
                          onPressed: () {
                            login();
                          },
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RegisterScreen.routeName);
                            },
                            child: Text("Don't have an Account?",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            )
                        )
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      //todo: register with firebase auth
      DialogUtils.showLoading(context, 'Loading');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = await FirebaseUtilities.readUserFromFireStore(credential.user?.uid??'');
        if(user == null){
          return ;
        }
        var authProvider = Provider.of<AuthProviders>(context,listen: false);
        authProvider.updateUser(user);
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context, 'Login Succuessfully',
            title: 'Success',
            posActionName: 'Ok',
            posAction: (){Navigator.of(context).pushNamed(HomeScreen.routeName);
            });
        print(credential.user?.uid??'');
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(context, 'No user found for that email.', title: 'Error',
              posActionName: 'Ok');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(context, 'Wrong password provided for that user.', title: 'Error',
              posActionName: 'Ok');
          print('Wrong password provided for that user.');
        }
      }
      catch(e){
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context, '${e.toString()}',
            title: 'Error',
            posActionName: 'Ok',
            );
        print(e.toString());
      }
    }
  }
}

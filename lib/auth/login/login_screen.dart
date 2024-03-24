import 'package:flutter/material.dart';
import 'package:todo_app_2/components/custom_text_form_field.dart';

import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
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

  void login() {
    if (formKey.currentState?.validate() == true) {
      //todo: register with firebase auth
    }
  }
}

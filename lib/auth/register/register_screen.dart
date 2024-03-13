import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/main_background.png',
          width: double.infinity,
          fit: BoxFit.fill,
          ),
          Form(child: Column(
            children: [
              TextFormField()
            ],
          ))
        ],
      ),
    );
  }
}
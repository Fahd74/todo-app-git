import 'package:flutter/cupertino.dart';
import 'package:todo_app_2/model/my_user.dart';

class AuthProviders extends ChangeNotifier{
  MyUser? currentUser ;
  void updateUser(MyUser newUser){
    currentUser = newUser;
    notifyListeners();
  }
}
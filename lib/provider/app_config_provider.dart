import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase_utilities.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }

  void refreshTasks(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtilities.getTasksCollection(uId).get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    tasksList = tasksList.where((task) {
      if (task.dateTime?.day == selectDate.day &&
          task.dateTime?.month == selectDate.month &&
          task.dateTime?.year == selectDate.year) {
        return true;
      }
      return false;
    }).toList();
    tasksList.sort((Task task1, Task task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });

    notifyListeners();
  }

  void changeSelectDate(DateTime newDate,String uId) {
    selectDate = newDate;
    refreshTasks(uId);
  }
}

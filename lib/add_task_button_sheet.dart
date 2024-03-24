import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_2/dialog_utils.dart';
import 'package:todo_app_2/firebase_utilities.dart';
import 'package:todo_app_2/model/task.dart';
import 'package:todo_app_2/provider/app_config_provider.dart';
import 'package:todo_app_2/provider/auth_provider.dart';

class AddTaskButtonSheet extends StatefulWidget {
  @override
  State<AddTaskButtonSheet> createState() => _AddTaskButtonSheetState();
}

class _AddTaskButtonSheetState extends State<AddTaskButtonSheet> {
  DateTime selectDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            'Add New Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Task Title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: 'Enter Task Title'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Task Description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Task Description',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Select Date',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showCalender();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${selectDate.day}/${selectDate.month}/${selectDate.year}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Text(
                        'Add',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ))
                ],
              ))
        ],
      ),
    );
  }

  void showCalender() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: selectDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chooseDate != null) selectDate = chooseDate;
    setState(() {});
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task =
          Task(title: title, description: description, dateTime: selectDate);
      DialogUtils.showLoading(context,'Loading...');
      var authProvider = Provider.of<AuthProviders>(context,listen: false);
      FirebaseUtilities.addTaskToFireStore(task,authProvider.currentUser!.id!)
          .then((value) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, 'Task added Successfully',
        posActionName: 'Ok',
        posAction: (){
          Navigator.pop(context);
        });

      })
          .timeout(Duration(microseconds: 500),
          onTimeout: () {
        print('task added succuessfully');
        listProvider.refreshTasks(authProvider.currentUser!.id!);
        Navigator.pop(context);
      });
    }
  }
}

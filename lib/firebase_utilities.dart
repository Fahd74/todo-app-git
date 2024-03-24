import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_2/model/my_user.dart';
import 'package:todo_app_2/model/task.dart';

class FirebaseUtilities {
  static CollectionReference<Task> getTasksCollection(String uId) {
    return getUsersCollection().doc(uId).collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
    // FirebaseFirestore.instance.collection(Task.collectionName)
    //   .withConverter<Task>(
    //       fromFirestore: (snapshot, options) =>
    //           Task.fromFireStore(snapshot.data()!),
    //       toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task,String uId) {
    var taskCollection = getTasksCollection(uId);
    var docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task,String uId) {
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (user, options) => user.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapShot = await getUsersCollection().doc(uId).get();
    return querySnapShot.data();
  }
}

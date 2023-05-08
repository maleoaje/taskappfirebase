import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskappfirebase/models/task.dart';

class FirestoreRepository {
  // create task
  static Future<void> create({Task? task}) async {
    try {
      await FirebaseFirestore.instance
          .collection(GetStorage().read('email'))
          .doc(task!.id)
          .set(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // get tasks
  static Future<List<Task>> get() async {
    List<Task> taskList = [];
    try {
      final data = await FirebaseFirestore.instance
          .collection(GetStorage().read('email'))
          .get();
      for (var task in data.docs) {
        taskList.add(Task.fromMap(task.data()));
      }
      return taskList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // update Task
  static Future<void> update({Task? task}) async {
    try {
      final data =
          FirebaseFirestore.instance.collection(GetStorage().read('email'));
      data.doc(task!.id).update(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // delete Task
  static Future<void> delete({Task? task}) async {
    try {
      final data =
          FirebaseFirestore.instance.collection(GetStorage().read('email'));
      data.doc(task!.id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // delete Task
  static Future<void> deleteAllRemoved({List<Task>? taskList}) async {
    try {
      final data =
          FirebaseFirestore.instance.collection(GetStorage().read('email'));
      for (var task in taskList!) {
        data.doc(task.id).delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

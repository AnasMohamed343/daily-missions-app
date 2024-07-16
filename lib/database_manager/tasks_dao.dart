import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_missions_app/database_manager/model/task.dart';
import 'package:daily_missions_app/database_manager/user_dao.dart';

class TasksDao {
  static CollectionReference<Task> getTasksCollection(String uid) {
    var userDoc = UserDao.getUsersCollection().doc(uid);
    return userDoc.collection(Task.collectionName).withConverter(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static Future<void> addTask(Task task, String uid) {
    var docRef = getTasksCollection(uid).doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<List<Task>> getAllTasks(String uid) async {
    var snapShot = await getTasksCollection(uid).get();
    var tasksList = snapShot.docs.map((snapShot) => snapShot.data()).toList();
    return tasksList;
  }

  static Stream<List<Task>> getTasksRealTimeUpdates(
      String uid, DateTime selectedDate) async* {
    var tasksCollection =
        getTasksCollection(uid).where(isEqualTo: selectedDate, 'dateTime');
    var snapShot = tasksCollection.snapshots();
    var tasksList = snapShot.map((tasksCollectionSnapShot) =>
        tasksCollectionSnapShot.docs
            .map((tasksSnapShot) => tasksSnapShot.data())
            .toList());
    yield* tasksList;
  }

  static Future<void> deleteTaskFromDb(String uid, String id) {
    var taskCollection = getTasksCollection(uid);
    return taskCollection.doc(id).delete();
  }

  static updateTaskInDb(String uid, Task task) {
    var taskCollection = getTasksCollection(uid);
    return taskCollection.doc(task.id).update(task.toFireStore());
  }
}

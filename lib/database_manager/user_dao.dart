import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_missions_app/database_manager/model/user.dart';

class UserDao {
  //data access object

  static CollectionReference<User> getUsersCollection() {
    var db = FirebaseFirestore.instance; // take obj from database
    return db.collection('Users').withConverter(
          fromFirestore: (snapshot, options) =>
              User.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUser(User user) {
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(user.id);
    return doc.set(user);
  }

  static Future<User?> getUser(String uid) async {
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();
  }
}

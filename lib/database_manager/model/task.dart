import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static const String collectionName = 'Tasks';
  String? id;
  String? title;
  String? description;
  Timestamp? dateTime;
  bool isDone;
  bool deleted; // Add this property

  Task({
    this.id,
    this.title,
    this.dateTime,
    this.description,
    this.isDone = false,
    this.deleted = false,
  });

  Task.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          title: data?['title'],
          description: data?['description'],
          dateTime: data?['dateTime'],
          isDone: data?['isDone'],
          deleted: data?['deleted'] ?? false, // Add this line
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime,
      'isDone': isDone,
      'deleted': deleted, // Add this line
    };
  }
}

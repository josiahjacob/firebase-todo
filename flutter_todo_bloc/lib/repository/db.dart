import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  final db = FirebaseFirestore.instance;
 


  Stream<QuerySnapshot> init() {
    return db.collection('CRUD').snapshots();
  }

  Future<String> createData(String name) async {
    DocumentReference ref = await db
        .collection('CRUD')
        .add({'name': '$name 😎', 'todo': randomTodo()});
    print(ref.id);
    return ref.id;
  }

  void readData(String id) async {
    DocumentSnapshot snapshot = await db.collection('CRUD').doc(id).get();
    print(snapshot[0].data()['name']);
  }

  void updateData(DocumentSnapshot doc) async {
    await db
        .collection('CRUD')
        .doc(doc.id)
        .update({'todo': 'please 🤫'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('CRUD').doc(doc.id).delete();
  }

  // Should not be inside here but probably inside a todoObject
  String randomTodo() {
    final randomNumber = Random().nextInt(4);
    String todo;
    switch (randomNumber) {
      case 1:
        todo = 'Like and subscribe 💩';
        break;
      case 2:
        todo = 'Twitter @robertbrunhage 🤣';
        break;
      case 3:
        todo = 'Patreon in the description 🤗';
        break;
      default:
        todo = 'Leave a comment 🤓';
        break;
    }
    return todo;
  }
}

DB db = DB();

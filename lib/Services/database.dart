import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_operations/models/brew_model.dart';
import 'package:firebase_crud_operations/models/users.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({
    this.uid,
  });
  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('data');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Brew(
          // name: (snapshot.docs.data())['name'] ?? '',
          name: doc['name'] ?? 'name field empty',
          strength: doc['strength'] ?? 0,
          sugars: doc['sugars'] ?? '0');
    }).toList();
  }

  //userData frm snapshot
  UserData _userDatafromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid.toString(), 
       name: snapshot['name'] ,
          strength: snapshot['strength'],
          sugars: snapshot['sugars']);
  }

  //get data streams
  // Stream<QuerySnapshot> get datas {
  //   return brewCollection.snapshots();
  // }
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user data doc stream
  // Stream<DocumentSnapshot> get userData {
  //   return brewCollection.doc(uid).snapshots();
  // }
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
    .map(_userDatafromSnapshot);
  }
}

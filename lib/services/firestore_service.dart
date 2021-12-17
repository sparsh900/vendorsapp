import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  FirestoreService._();
  static final instance=FirestoreService._();

  Future<void> setData({@required String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    print('$path : $data');
    await reference.setData(data);
  }

  Future<DocumentSnapshot> getData({@required String path, String documentId}) async {
    final document = Firestore.instance.collection(path).document(documentId);
    final snapshot=document.get();
    return snapshot;
  }

  Future<DocumentSnapshot> getDataFromName({@required String path, String name}) async {
    final documents= await Firestore.instance.collection(path).where(
        'name',
        isEqualTo: name
    ).getDocuments();
    final document=documents.documents[0];
    return document;
  }

  Future<void> deleteData({@required String path}) async {
    final reference = Firestore.instance.document(path);
    await reference.delete();
  }

  Future<void> deleteCollection({@required String path}) async {
    Firestore.instance.collection(path).getDocuments().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.documents) {
        doc.reference.delete();
      }
    });
  }

  Future<void> updateData({@required String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    print('$path : $data');
    await reference.updateData(data);
  }

  Stream<List<T>> collectionStream<T>(
      {@required String path, @required T builder(Map<String, dynamic> data, String documentId)}) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.documents.map((snapshot) => builder(snapshot.data,snapshot.documentID)).toList());
  }

  Stream<List<T>> orderedCollectionStream<T>(
      {@required String path,@required String field,bool descending=false, @required T builder(Map<String, dynamic> data, String documentId)}) {
    final reference = Firestore.instance.collection(path).orderBy(field,descending: descending);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.documents.map((snapshot) => builder(snapshot.data,snapshot.documentID)).toList());
  }

  Stream<List<T>> limitedCollectionStream<T>(
      {@required String path, @required T builder(Map<String, dynamic> data, String documentId),String order,@required int limitLength}) {
    final reference = Firestore.instance.collection(path).limit(limitLength);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.documents.map((snapshot) => builder(snapshot.data,snapshot.documentID)).toList());
  }

}
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vendors_app/app/models/appointment.dart';
import 'package:vendors_app/app/models/pet.dart';
import 'package:vendors_app/app/models/user.dart';
import 'package:vendors_app/app/models/vet.dart';
import 'package:vendors_app/services/api_path.dart';
import 'package:vendors_app/services/firestore_service.dart';

abstract class Database {
  String getUid();
  Future<void> setVet(Vet vet);
  Future<bool> checkVetData();
  Future<bool> checkVetVerification();
  Future<Pet> getPet(String userId, String name);
  Future<UserData> getPatient(String patientId);
  Stream<List<Appointment>> appointmentsStream();
  Future<void> updateAppointment(Appointment appointment, String status);
  Future<Vet> getVet();
  Future<void> updateDeviceToken(Vet vet, String deviceToken);
  Future<void> saveNotification(String message, String notificationId);
  Stream<List<Map>> notificationsStream();
  Future<void> deleteNotification(String notificationId);
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final uid;
  final _service = FirestoreService.instance;

  String getUid() {
    return uid;
  }

  Future<void> setVet(Vet vet) async => await _service.setData(
        path: APIPath.vet(uid),
        data: vet.toMap(),
      );

  Future<bool> checkVetData() async {
    final snapshot =
        await _service.getData(path: APIPath.vets(), documentId: uid);

    if (!snapshot.exists) {
      return false;
    }
    return snapshot.data.containsKey("Name");
  }

  Future<bool> checkVetVerification() async {
    final snapshot =
        await _service.getData(path: APIPath.vets(), documentId: uid);
    if (snapshot.data['verified'] == null) {
      return false;
    }

    return snapshot.data['verified'];
  }

  Future<Pet> getPet(String userId, String name) async {
    final snapshot =
        await _service.getDataFromName(path: APIPath.pets(userId), name: name);
    return Pet.fromMap(snapshot.data, snapshot.documentID);
  }

  Future<UserData> getPatient(String patientId) async {
    final snapshot =
        await _service.getData(path: APIPath.users(), documentId: patientId);
    return UserData.fromMap(snapshot.data);
  }

  Stream<List<Appointment>> appointmentsStream() =>
      _service.orderedCollectionStream(
        path: APIPath.appointments(uid),
        field: 'date',
        descending: false,
        builder: (data, documentId) => Appointment.fromMap(data, documentId),
      );

  Stream<List<Map>> notificationsStream() =>
      _service.collectionStream(path: APIPath.notifications(uid), builder: (data,documentId) {
        return {
          'message': data['message'],
          'id' : documentId,
        };
      });

  Future<void> updateAppointment(Appointment appointment, String status) =>
      _service.updateData(
        path: APIPath.appointmentVet(uid, appointment.id),
        data: appointment.vetAppToMap(status),
      );

  Future<Vet> getVet() async {
    final snapshot =
        await _service.getData(path: APIPath.vets(), documentId: uid);
    return Vet.fromMap(snapshot.data, snapshot.documentID);
  }

  Future<void> updateDeviceToken(Vet vet, String deviceToken) async =>
      _service.updateData(
        path: APIPath.vet(uid),
        data: vet.toMap(deviceTokenLocal: deviceToken),
      );

  Future<void> saveNotification(String message, String notificationId) async =>
      _service.setData(
        path: APIPath.notification(uid, notificationId),
        data: {'message': message},
      );

  Future<void> deleteNotification(String notificationId) async => _service.deleteData(path: APIPath.notification(uid, notificationId));
}

//    snapshots.listen((snapshot) { // collection snapshot
//      snapshot.documents.forEach((snapshot) => snapshot.data);// document snapshot
//    });

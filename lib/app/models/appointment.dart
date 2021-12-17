import 'package:flutter/foundation.dart';

class Appointment {
  Appointment({@required this.time,@required this.date,@required this.doctorId,this.patientId,@required this.mode,@required this.id,@required this.petName,@required this.status});
  String id;
  String time;
  String date;
  String doctorId;
  String patientId;
  String mode;
  String petName;
  String status;

  factory Appointment.fromMap(Map<String, dynamic> data,String documentId) {
    if (data == null) {
      return null;
    } else {
      final String time = data['time'];
      final String date = data['date'];
      final String doctorId = data['doctorId'];
      final String patientId = data['patientId'];
      final String mode = data['mode'];
      final String petName= data['petName'];
      final String status= data['status'];
      return Appointment(
        id: documentId,
        time: time,
        date: date,
        doctorId: doctorId,
        patientId: patientId,
        mode:mode,
        petName: petName,
        status: status,
      );
    }
  }

  Map<String, dynamic> toMap(String uid) {
    return {
      'time': time,
      'date': date,
      'doctorId': doctorId,
      'patientId': uid,
      'mode': mode,
      'petName' : petName,
      'status' : status,
    };
  }

  Map<String, dynamic> vetAppToMap(String status) {
    return {
      'time': time,
      'date': date,
      'doctorId': doctorId,
      'patientId': patientId,
      'mode': mode,
      'petName' : petName,
      'status' : status,
    };
  }
}
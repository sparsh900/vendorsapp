import 'package:flutter/cupertino.dart';

class Vet {
  Vet({
    @required this.Name,
    @required this.clinicName,
    @required this.imagePath,
    @required this.iconPath,
    @required this.openTime,
    @required this.closeTime,
    @required this.phone,
    @required this.experience,
    @required this.Achievements,
    @required this.Address,
    @required this.Qualification,
    @required this.city,
    @required this.state,
    @required this.zip,
    @required this.locationData,
    @required this.gstin,
    @required this.verified,
    @required this.deviceToken,
    @required this.isHomeVisit,
    @required this.isVisitClinic,
    @required this.isChat,
    @required this.isVideo,
    @required this.isVaccine,
    @required this.isDeworming,
    @required this.isConsultation,
    @required this.cost,
    this.id,
  });
  final String Name, experience, state, phone, zip, city, Achievements;
  final String Address, openTime, clinicName, imagePath, iconPath;
  final String Qualification, closeTime,gstin;
  final String id,deviceToken;
  final bool verified;
  final Map<dynamic, dynamic> locationData;
  final bool isHomeVisit;
  final bool isVisitClinic;
  final bool isChat;
  final bool isVideo;
  final bool isVaccine,isDeworming,isConsultation;
  final double cost;

  factory Vet.fromMap(Map<String, dynamic> data,String documentId) {
    if (data == null) {
      return null;
    } else {
      final String Name = data['Name'];
      final String Address = data['Address'];
      final String Qualification = data['Qualification'];
      final String Achievements = data['Achievements'];
      final String city = data['city'];
      final String experience = data['experience'];
      final String state = data['state'];
      final String phone = data['phone'];
      final String zip = data['zip'];
      final String closeTime = data['closeTime'];
      final String openTime = data['openTime'];
      final String clinicName = data['clinicName'];
      final String imagePath = data['imagePath'];
      final String iconPath = data['iconPath'];
      final String gstin=data['gstin'];
      final String id = documentId;
      final bool verified = data['verified'];
      final Map<dynamic, dynamic> locationData = data['locationData'];
      final String deviceToken=data['deviceToken'];
      final bool isHomeVisit=data['isHomeVisit'];
      final bool isVisitClinic=data['isVisitClinic'];
      final bool isChat=data['isChat'];
      final bool isVideo=data['isVideo'];
      final bool isVaccine=data['isVaccine'];
      final bool isDeworming=data['isDeworming'];
      final bool isConsultation=data['isConsultation'];
      final double cost=data['cost'];
      return Vet(
        Name: Name,
        Address: Address,
        Qualification: Qualification,
        locationData: locationData,
        Achievements: Achievements,
        city: city,
        zip: zip,
        state: state,
        experience: experience,
        phone: phone,
        closeTime: closeTime,
        openTime: openTime,
        clinicName: clinicName,
        imagePath: imagePath,
        iconPath: iconPath,
        gstin: gstin,
        verified: verified,
        id: documentId,
        deviceToken: deviceToken,
        isChat:isChat,
        isVideo:isVideo,
        isVisitClinic:isVisitClinic,
        isHomeVisit:isHomeVisit,
        isConsultation:isConsultation,
        isVaccine:isVaccine,
        isDeworming:isDeworming,
        cost:cost,
      );
    }
  }

  Map<String, dynamic> toMap({String deviceTokenLocal}) {
    return {
      'Name': Name,
      'Address': Address,
      'Qualification' : Qualification,
      'Achievements' : Achievements,
      'city' : city,
      'experience' : experience,
      'state' : state,
      'phone' : phone,
      'zip' : zip,
      'closeTime' : closeTime,
      'openTime' : openTime,
      'clinicName' : clinicName,
      'imagePath' : imagePath,
      'iconPath' : iconPath,
      'gstin' : gstin,
      'locationData' : locationData,
      'verified' : verified,
      'deviceToken' : deviceTokenLocal??deviceToken,
      'isChat':isChat,
      'isVideo':isVideo,
      'isVisitClinic':isVisitClinic,
      'isHomeVisit':isHomeVisit,
      'isConsultation':isConsultation,
      'isVaccine':isVaccine,
      'isDeworming':isDeworming,
      'cost':cost,
    };
  }
}

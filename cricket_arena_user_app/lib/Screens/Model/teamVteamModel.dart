// Pehla email pass wala kam hai yh
// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamVTeamModel {
  String? uid;
  String? email;
  String? fullName;
  String? teamName;
  String? phoneNumber;
  String? status;

  TeamVTeamModel({
    this.uid,
    this.email,
    this.fullName,
    this.teamName,
    this.phoneNumber,
    this.status,
  });

  // receiving data from server
  factory TeamVTeamModel.fromMap(map) {
    return TeamVTeamModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      teamName: map['teamName'],
      phoneNumber: map['phoneNumber'],
      status: map['status'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'teamName': teamName,
      'phoneNumber': phoneNumber,
      'status': status,
    };
  }
}

// Pehla email pass wala kam hai yh
// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamMatchhModel {
  String? userUid;
  String? teamUid;
  String? email;
  String? userName;
  String? userTeamName;
  String? userPhone;
  String? teamName;
  String? teamHeadName;
  String? teamHeadPhone;
  String? status;

  TeamMatchhModel({
    this.userUid,
    this.teamUid,
    this.email,
    this.userName,
    this.userTeamName,
    this.userPhone,
    this.teamName,
    this.teamHeadName,
    this.teamHeadPhone,
    this.status,
  });

  // receiving data from server
  factory TeamMatchhModel.fromMap(map) {
    return TeamMatchhModel(
      userUid: map['userUid'],
      teamUid: map['teamUid'],
      email: map['email'],
      userName: map['userName'],
      userTeamName: map['userTeamName'],
      userPhone: map['userPhone'],
      teamName: map['teamName'],
      teamHeadName: map['teamHeadName'],
      teamHeadPhone: map['teamHeadPhone'],
      status: map['status'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'userUid': userUid,
      'teamUid': teamUid,
      'email': email,
      'userName': userName,
      'userTeamName': userTeamName,
      'userPhone': userPhone,
      'teamName': teamName,
      'teamHeadName': teamHeadName,
      'teamHeadPhone': teamHeadPhone,
      'status': status,
    };
  }
}

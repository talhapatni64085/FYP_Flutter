// Pehla email pass wala kam hai yh
// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingTournamentModel {
  String? uid;
  String? tournamentName;
  String? location;
  String? entryFees;
  String? numberOfTeams;
  String? rulesAndRegulations;
  String? tournamentUID;
  String? time;
  String? status;
  String? userName;
  String? userPhoneNumber;

  BookingTournamentModel({
    this.uid,
    this.tournamentName,
    this.location,
    this.entryFees,
    this.numberOfTeams,
    this.rulesAndRegulations,
    this.tournamentUID,
    this.time,
    this.status,
    this.userName,
    this.userPhoneNumber,
  });

  // receiving data from server
  factory BookingTournamentModel.fromMap(map) {
    return BookingTournamentModel(
      uid: map['uid'],
      tournamentName: map['tournamentName'],
      location: map['location'],
      entryFees: map['entryFees'],
      numberOfTeams: map['numberOfTeams'],
      rulesAndRegulations: map['rulesAndRegulations'],
      tournamentUID: map['tournamentUID'],
      time: map['time'],
      status: map['status'],
      userName: map['userName'],
      userPhoneNumber: map['userPhoneNumber'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'tournamentName': tournamentName,
      'location': location,
      'entryFees': entryFees,
      'numberOfTeams': numberOfTeams,
      'rulesAndRegulations': rulesAndRegulations,
      'tournamentUID': tournamentUID,
      'time': time,
      'status': status,
      'userName': userName,
      'userPhoneNumber': userPhoneNumber,
    };
  }
}

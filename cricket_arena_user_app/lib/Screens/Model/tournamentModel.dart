// Pehla email pass wala kam hai yh
// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TournamentModel {
  String? uid;
  String? tournamentName;
  String? location;
  String? entryFees;
  String? numberOfTeams;
  String? rulesAndRegulations;
  String? time;
  String? status;

  TournamentModel({
    this.uid,
    this.tournamentName,
    this.location,
    this.entryFees,
    this.numberOfTeams,
    this.rulesAndRegulations,
    this.time,
    this.status,
  });

  // receiving data from server
  factory TournamentModel.fromMap(map) {
    return TournamentModel(
      uid: map['uid'],
      tournamentName: map['tournamentName'],
      location: map['location'],
      entryFees: map['entryFees'],
      numberOfTeams: map['numberOfTeams'],
      rulesAndRegulations: map['rulesAndRegulations'],
      time: map['time'],
      status: map['status'],
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
      'time': time,
      'status': status,
    };
  }
}

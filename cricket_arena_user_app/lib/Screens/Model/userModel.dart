// Pehla email pass wala kam hai yh
// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? password;
  String? category;
  String? matches;
  String? runs;
  String? wickets;
  String? team;

  UserModel({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.password,
    this.category,
    this.matches,
    this.runs,
    this.wickets,
    this.team,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      category: map['category'],
      matches: map['matches'],
      runs: map['runs'],
      wickets: map['wickets'],
      team: map['team'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'password': password,
      'category': category,
      'matches': matches,
      'runs': runs,
      'wickets': wickets,
      'team': team,
    };
  }

  void add(values) {}
}

// Pehla email pass wala kam hai yh
// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroundModel {
  String? uid;
  String? email;
  String? groundName;
  String? phoneNumber;
  String? password;
  String? location;
  String? price;
  String? description;

  GroundModel({
    this.uid,
    this.email,
    this.groundName,
    this.phoneNumber,
    this.password,
  this.location,
  this.price,
  this.description,
  });

  // receiving data from server
  factory GroundModel.fromMap(map) {
    return GroundModel(
      uid: map['uid'],
      email: map['email'],
      groundName: map['groundName'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      location: map['location'],
      price: map['price'],
      description: map['description']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'groundName': groundName,
      'phoneNumber': phoneNumber,
      'password': password,
      'location': location,
      'price': price,
      'description': description,
    };
  }
}

// Pehla email pass wala kam hai yh
// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroundBookingModel {
  String? uid;
  String? bookingDay;
  String? groundPrice;
  String? userName;
  String? userContact;
  String? status;
  String? groundUid;
  String? groundName;
  String? groundContact;
  String? date;
  String? userEmail;
  String? groundEmail;
  String? bookingSlot;
  String? groundLocation;

  GroundBookingModel({
    this.uid,
    this.bookingDay,
    this.groundPrice,
    this.userName,
    this.userContact,
    this.status,
    this.groundUid,
    this.groundName,
    this.groundContact,
    this.date,
    this.userEmail,
    this.groundEmail,
    this.bookingSlot,
    this.groundLocation,
  });

  // receiving data from server
  factory GroundBookingModel.fromMap(map) {
    return GroundBookingModel(
      uid: map['uid'],
      bookingDay: map['booking day'],
      groundPrice: map['ground price'],
      userName: map['user name'],
      userContact: map['user contact'],
      groundName: map['ground name'],
      groundContact: map['ground contact'],
      status: map['status'],
      groundUid: map['ground uid'],
      date: map['date'],
      userEmail: map['user email'],
      groundEmail: map['ground email'],
      bookingSlot: map['booking slot'],
      groundLocation: map['ground location'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'booking day': bookingDay,
      'ground price': groundPrice,
      'user name': userName,
      'user contact': userContact,
      'status': status,
      'ground uid': groundUid,
      'ground name': groundName,
      'ground contact': groundContact,
      'date': date,
      'user email': userEmail,
      'ground email': groundEmail,
      'booking slot': bookingSlot,
      'ground location': groundLocation,
    };
  }
}
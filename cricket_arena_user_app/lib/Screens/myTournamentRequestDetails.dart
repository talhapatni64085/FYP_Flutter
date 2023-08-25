// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:user_app/Screens/Model/tournamentModel.dart';
import 'package:user_app/Screens/bookAGround.dart';
import 'package:user_app/Screens/editProfile.dart';
import 'package:user_app/Screens/tournaments.dart';

class MyTournamentRequestDetails extends StatefulWidget {
  final String documentId;
  MyTournamentRequestDetails({Key? key, required this.documentId})
      : super(key: key);

  @override
  State<MyTournamentRequestDetails> createState() => _MyTournamentRequestDetailsState();
}

class _MyTournamentRequestDetailsState extends State<MyTournamentRequestDetails> {

  

  var size, height, width;

  CollectionReference workers =
      FirebaseFirestore.instance.collection('tournamentBooking');

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(214, 102, 50, 98),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Text("Pending Tournament Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                color: Colors.white,
                margin: EdgeInsets.only(top: 5),
                child: FutureBuilder<DocumentSnapshot>(
                  future: workers.doc(widget.documentId).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something Went wrong");
                    }
                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          Text("Data does not exists"),
                        ],
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                                           return ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: Color.fromARGB(214, 102, 50, 98)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                      spreadRadius: 4)
                                ]),
                            child: Column(
                              children: [
                                
                                Center(
                                  child: Column(
                                    children: [
                                      Text("Tournament Name"),
                                      Text(
                                        "${data['tournamentName']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,                                        children: [
                                          Text(
                                            "Status:",
                                            style: TextStyle(
                                                fontSize: 14, color: Colors.black),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(
                                            "${data['status']}",
                                            style: TextStyle(
                                                fontSize: 14, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      
                                    ],
                                  ),
                                ),
                                // SizedBox(height: 5),
                                Divider(color: Colors.grey),
                                Center(
                                  child: Text(
                                    "${data['location']}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              
                                color: Color.fromARGB(214, 102, 50, 98),
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                      spreadRadius: 1)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.money,
                                    color: Colors.white,
                                  ),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Number of teams', style: TextStyle(color: Colors.white)),
                                      Text("${data['numberOfTeams']}",
                                          style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                  leading: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Rules and regulations',
                                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                                      Text("${data['rulesAndRegulations']}",
                                          style: TextStyle(color: Color.fromARGB(255, 255, 244, 244))),
                                    ],
                                  ),
                                ),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                    leading: Icon(Icons.money,
                                        color: Colors.white),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Entry Fees',
                                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                        ),
                                        Text(
                                          "${data['entryFees']}",
                                          style: TextStyle(color: Color.fromARGB(255, 255, 244, 244)),
                                        ),
                                      ],
                                    )),
                                    Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                    leading: Icon(Icons.punch_clock ,
                                        color: Colors.white),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Starting Time',
                                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                        ),
                                        Text(
                                          "${data['time']}",
                                          style: TextStyle(color: Color.fromARGB(255, 255, 244, 244)),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}
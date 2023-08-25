// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_app/Screens/Model/tournamentBookingModel.dart';

class TournamentDetails extends StatefulWidget {
  final String documentId;
  TournamentDetails({Key? key, required this.documentId})
      : super(key: key);

  @override
  State<TournamentDetails> createState() => _TournamentDetailsState();
}

class _TournamentDetailsState extends State<TournamentDetails> {

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser!;
    BookingTournamentModel bookingTournamentModel = BookingTournamentModel();

    // writing all the values
    bookingTournamentModel.uid = user.uid;
    bookingTournamentModel.tournamentName = tournamentDocs['tournamentName'];
    bookingTournamentModel.location = tournamentDocs['location'];
    bookingTournamentModel.entryFees = tournamentDocs['entryFees'];
    bookingTournamentModel.numberOfTeams = tournamentDocs['numberOfTeams'];
    bookingTournamentModel.rulesAndRegulations = tournamentDocs['rulesAndRegulations'];
    bookingTournamentModel.tournamentUID = tournamentDocs['uid'];
    bookingTournamentModel.time = tournamentDocs['time'];
    bookingTournamentModel.status = 'pending';
    bookingTournamentModel.userName = userDocs['fullName'];
    // bookingTournamentModel.bookingSlot = dropdownValue;
    bookingTournamentModel.userPhoneNumber = userDocs['phoneNumber'];

    await firebaseFirestore
        .collection('tournamentBooking')
        .doc()
        .set(bookingTournamentModel.toMap());
    Fluttertoast.showToast(msg: "tournament requested successfully");

    Navigator.pop(this.context);
  }

  var size, height, width;

  CollectionReference workers =
      FirebaseFirestore.instance.collection('tournaments');

var userDocs;
  var tournamentDocs;
  @override
  void initState() {
    super.initState();
    readTournaments().then((value) => {
          setState(() {
            tournamentDocs = value;
          print('heheheheheheheheheh $tournamentDocs');
          })
        });
    readUser().then((value) => {
          setState(() {
            userDocs = value;
          })
        });
  }
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
        title: Text("Tournament Details"),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          postDetailsToFirestore()
;                        },
                        minWidth: double.infinity,
                        color: Color.fromARGB(214, 102, 50, 98),
                        height: 50,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Book Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future readUser() async {
    var querySnapshot;
    try {
      querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (querySnapshot.isNotEmpty) {
        return querySnapshot;
      }
    } catch (e) {
      print(e);
    }
    return querySnapshot;
  }

  Future readTournaments() async {
    var querySnapshot;
    try {
      querySnapshot = await FirebaseFirestore.instance
          .collection('tournaments')
          .doc(widget.documentId)
          .get();
      if (querySnapshot.isNotEmpty) {
        return querySnapshot;
      }
    } catch (e) {
      print(e);
    }
    return querySnapshot;
  }
}
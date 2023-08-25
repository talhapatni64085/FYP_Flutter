// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_app/Screens/Model/teamMatchModel.dart';
import 'package:user_app/Screens/Model/teamVteamModel.dart';
import 'package:user_app/Screens/Model/tournamentBookingModel.dart';

class TeamVsTeamDetails extends StatefulWidget {
  final String documentId;
  TeamVsTeamDetails({Key? key, required this.documentId})
      : super(key: key);

  @override
  State<TeamVsTeamDetails> createState() => _TeamVsTeamDetailsState();
}

class _TeamVsTeamDetailsState extends State<TeamVsTeamDetails> {

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser!;
    TeamMatchhModel teamVsTeamModel = TeamMatchhModel();

    // writing all the values
    teamVsTeamModel.userUid = user.uid;
    teamVsTeamModel.teamUid = widget.documentId;
    teamVsTeamModel.teamName = teamDocs['teamName'];
    teamVsTeamModel.teamHeadName = teamDocs['fullName'];
    teamVsTeamModel.teamHeadPhone = teamDocs['phoneNumber'];
    teamVsTeamModel.userName = userDocs['fullName'];
    teamVsTeamModel.userPhone = userDocs['phoneNumber'];
    teamVsTeamModel.userTeamName = userTeamDocs['fullName'];
    teamVsTeamModel.status = 'pending';

    await firebaseFirestore
        .collection('teamVsTeam')
        .doc()
        .set(teamVsTeamModel.toMap());
    Fluttertoast.showToast(msg: "Match request sent successfully");

    Navigator.pop(this.context);
  }

  var size, height, width;

  CollectionReference workers =
      FirebaseFirestore.instance.collection('teams');

var userDocs;
  var teamDocs;
  var userTeamDocs;
  @override
  void initState() {
    super.initState();
    readUserTeam().then((value) => {
          setState(() {
            userTeamDocs = value;
          print('heheheheheheheheheh $userTeamDocs');
          })
        });
    readTeam().then((value) => {
          setState(() {
            teamDocs = value;
          print('heheheheheheheheheh $teamDocs');
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
        title: Text("Team Details"),
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
                                      Text("Team Name"),
                                      Text(
                                        "${data['teamName']}",
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
                                    "${data['fullName']}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ),
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
                          children: const [
                            Text(
                              "Request a match",
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

  Future readTeam() async {
    var querySnapshot;
    try {
      querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
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

  Future readUserTeam() async {
    var querySnapshot;
    try {
      querySnapshot = await FirebaseFirestore.instance
          .collection('teams')
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
}
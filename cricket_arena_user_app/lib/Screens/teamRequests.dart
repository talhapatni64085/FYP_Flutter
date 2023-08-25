// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_app/Screens/createTeamDetail.dart';
import 'package:user_app/Screens/groundDetails.dart';
import 'package:user_app/Screens/myPendingTournamentDetails.dart';
import 'package:user_app/Screens/pendingTournamentDetails.dart';
import 'package:user_app/Screens/editProfile.dart';
import 'package:user_app/Screens/teamRequestsDetails.dart';
import 'package:user_app/Screens/tournamentDetails.dart';
import 'package:user_app/Screens/tournamentRequestDetails.dart';
import 'package:user_app/Screens/yourTournamentDetails.dart';

class TeamRequests extends StatefulWidget {
  const TeamRequests({Key? key}) : super(key: key);

  @override
  _TeamRequestsState createState() => _TeamRequestsState();
}

class _TeamRequestsState extends State<TeamRequests> {
  // List checkboxStatus = [];
  bool _checked = false;
  var size, height, width;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('invitations')
      .where('team',isEqualTo: 'Pending')
      .where('playerUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    
  final searchEditingController = new TextEditingController();

    final searchField = TextFormField(
        autofocus: false,
        controller: searchEditingController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          searchEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          suffixIcon: const Icon(Icons.search, color: Colors.white,),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Search", focusColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white)
          ),
        ));

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
        title: Text('Team Requests'),
        
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.size == 0) {
            return Center(child: Text('Your Request list is empty'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  // height: 120,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                        spreadRadius: 1)
                  ]),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(Icons.person, size: 50,),
                        title: Text(data['userName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['userContact']),
                            Text(data['date']),
                          ],
                        ),
                        // trailing: Checkbox(
                        //         value: _checked,
                        //         onChanged: (bool? value) {
                        //           // print(checkboxStatus.length);
                        //           setState((() {
                        //             _checked =
                        //             !_checked;
                        //           }));
                        //         },
                        //         checkColor: Colors.white,
                        //       )
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TeamRequestsDetails(
                                    documentId: document.id,
                                    uid: data['playerUid'],
                                  )));
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
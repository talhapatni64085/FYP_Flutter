// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/Screens/groundDetails.dart';
import 'package:user_app/Screens/myPendingTournamentDetails.dart';
import 'package:user_app/Screens/pendingTournamentDetails.dart';
import 'package:user_app/Screens/editProfile.dart';
import 'package:user_app/Screens/tournamentDetails.dart';
import 'package:user_app/Screens/tournamentRequestDetails.dart';
import 'package:user_app/Screens/yourTournamentDetails.dart';

class CompletedTournaments extends StatefulWidget {
  const CompletedTournaments({Key? key}) : super(key: key);

  @override
  _CompletedTournamentsState createState() => _CompletedTournamentsState();
}

class _CompletedTournamentsState extends State<CompletedTournaments> {
  var size, height, width;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('tournaments')
      .where('uid',isEqualTo: user!.uid)
      .where('status', isEqualTo: 'Completed')
      .snapshots();

  @override
  Widget build(BuildContext context) {
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
        title: Text("My Completed Tournaments"),
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
            return Center(child: Text('Your tournament list is empty'));
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
                        leading: Image(
                          image: AssetImage('assets/logo_1.png'),
                        ),
                        title: Text(data['tournamentName']),
                        subtitle: Text(data['location']),
                        trailing: Text(data['status']),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TournamentRequestDetails(
                                    documentId: document.id,
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
// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_app/Screens/adminGroundDetails.dart';
import 'package:user_app/Screens/adminUserDetails.dart';
import 'package:user_app/Screens/editProfile.dart';
import 'package:user_app/Screens/groundDetails.dart';
import 'package:user_app/Screens/home.dart';
import 'package:user_app/Screens/profile.dart';

class AdminTeams extends StatefulWidget {
  const AdminTeams({Key? key}) : super(key: key);

  @override
  _AdminTeamsState createState() => _AdminTeamsState();
}

class _AdminTeamsState extends State<AdminTeams> {
  var size, height, width;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('teams')
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
        title: Text("Teams"),
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
            return Center(child: Text('Teams list is empty'));
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image(
                        image: AssetImage('assets/ground.png'),
                      ),
                      title: Text(data['teamName']),
                      subtitle: Text(data['status']),
                    ),
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
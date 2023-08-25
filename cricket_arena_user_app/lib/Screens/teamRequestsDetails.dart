// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as Firebase_Storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_app/Screens/Auth/login.dart';
import 'package:user_app/Screens/Model/createTeamModel.dart';
import 'package:user_app/Screens/createTeam.dart';
import 'package:user_app/Screens/grounds.dart';
import 'package:user_app/Screens/home.dart';


class TeamRequestsDetails extends StatefulWidget {
  final String documentId;
  final String uid;
  const TeamRequestsDetails({Key? key, required this.documentId, required this.uid}) : super(key: key);

  @override
  _TeamRequestsDetailsState createState() => _TeamRequestsDetailsState();
}

class _TeamRequestsDetailsState extends State<TeamRequestsDetails> {
  final auth = FirebaseAuth.instance.currentUser!;

  var size, height, width;

  bool isLoading = false;

  String? urlfinal = null;
  String? name = null;
  String? email = null;

  get_image(email) async {
    final ref = Firebase_Storage.FirebaseStorage.instance
        .ref()
        .child('userProfiles/')
        .child(email)
        .child('DP.jpg');
    var url = await ref.getDownloadURL();
    print(url);
    User auth = FirebaseAuth.instance.currentUser!;
    auth.updatePhotoURL(url);
    setState(() {
      urlfinal = url;
    });
    return "Done";
  }

  // method for logging out a current user
  Future logout() async {
    await FirebaseAuth.instance.signOut();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove("email");
    // prefs.remove("pass");
  }

  var playerDocs;
  var userDocs;
  void initState() {
    super.initState();
    readUser().then((value) => {
          setState(() {
            userDocs = value;
          })
        });
    readPlayer().then((value) => {
          setState(() {
            playerDocs = value;
          })
        });

    // name = auth.displayName;
    email = auth.email;
    // documentID = auth.uid;
    get_image(email);
  }

  


  @override
  Widget build(BuildContext context) {
    // CollectionReference for worker drawer and dashboard single data
    CollectionReference workers =
        FirebaseFirestore.instance.collection('invitations');
    // .doc(cat)
    // .collection(cat);
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Color.fromARGB(214, 102, 50, 98),
          title: Text("CRICKET ARENA", style: TextStyle(letterSpacing: 2),),
          actions: [
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
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
                            // Text(this.documentId),
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
                            ListTile(
                              title: Text(
                                "${data['userName']}",
                                style:
                                    TextStyle(fontSize: 25, color: Colors.black),
                              ),
                              trailing: urlfinal != null
                                      ? CircleAvatar(
                                          radius: 50.0,
                                          backgroundImage:
                                              NetworkImage(urlfinal!),
                                          backgroundColor: Colors.transparent,
                                        )
                                      : CircleAvatar(
                                          radius: 50.0,
                                          backgroundColor: Colors.transparent,
                                          child: CircularProgressIndicator(),
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
                                    leading: Icon(Icons.phone,
                                        color: Colors.white),
                                    title: Text(
                                      "${data['player contact']}",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                    leading: Icon(Icons.email,
                                        color: Colors.white),
                                    title: Text(
                                      "${data['playerEmail']}",
                                      style: TextStyle(color: Colors.white),
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
                
                          SizedBox(
                          height: height * 0.01,
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: Offset(2, 2),
                                  )
                                ]),
                            child: MaterialButton(
                              onPressed: () {
                                // postDetailsToFirestore();
                                AcceptUser(widget.uid);
                                AcceptInvi();
                                Navigator.pop(context);
                              },
                              color: Colors.white,
                              height: 45,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Accept",
                                style: TextStyle(
                                    color: Color.fromARGB(214, 102, 50, 98),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 3),
                              ),
                            ),
                          ),
                          SizedBox(
                          height: height * 0.01,
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: Offset(2, 2),
                                  )
                                ]),
                            child: MaterialButton(
                              onPressed: () {
                                DeleteUser(widget.uid);
                                DeleteInvi();
                                Navigator.pop(context);
                              },
                              color: Colors.white,
                              height: 45,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Color.fromARGB(214, 102, 50, 98),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 3),
                              ),
                            ),
                          ),
              ],
            ),
          ),
        ),
        
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            // fixedColor: Color.fromARGB(214, 102, 50, 98),
            selectedItemColor: Color.fromARGB(214, 102, 50, 98),
            unselectedItemColor: Colors.black,
            currentIndex: 2,
            iconSize: 25,
            onTap: (int index) => btn(index, context),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.stadium_outlined,
                ),
                label: 'Grounds',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: 'Account',
              ),
            ]));
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

  Future readPlayer() async {
    var querySnapshot;
    try {
      querySnapshot = await FirebaseFirestore.instance
          .collection('users')
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
  Future AcceptUser(id) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'team': 'Accept'}).then((value) => print('success'));
  }
  Future AcceptInvi() async {
    FirebaseFirestore.instance
        .collection('invitations')
        .doc(widget.documentId)
        .update({'team': 'Accept'}).then((value) => print('success'));
  }
  Future DeleteUser(id) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'team': '-'}).then((value) => print('success'));
    FirebaseFirestore.instance
        .collection('invitations')
        .doc(widget.documentId)
        .update({'team': 'Cancel'}).then((value) => print('success'));
  }
  Future DeleteInvi() async {
    FirebaseFirestore.instance
        .collection('invitations')
        .doc(widget.documentId)
        .update({'team': 'Cancel'}).then((value) => print('success'));
  }
} 

final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;
btn(i, context) {
  if (i == 0) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home()));
  } else if (i == 1) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Grounds()));
  } else {
  }
}

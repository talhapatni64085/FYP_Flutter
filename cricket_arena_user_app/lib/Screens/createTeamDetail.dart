// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as Firebase_Storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_app/Screens/Auth/login.dart';
import 'package:user_app/Screens/Model/createTeamModel.dart';
import 'package:user_app/Screens/Model/teamVteamModel.dart';
import 'package:user_app/Screens/createTeam.dart';
import 'package:user_app/Screens/grounds.dart';
import 'package:user_app/Screens/home.dart';


class CreateTeamDetails extends StatefulWidget {
  final String documentId;
  const CreateTeamDetails({Key? key, required this.documentId}) : super(key: key);

  @override
  _CreateTeamDetailsState createState() => _CreateTeamDetailsState();
}

class _CreateTeamDetailsState extends State<CreateTeamDetails> {
    final _auth = FirebaseAuth.instance;
  //  CollectionReference users = FirebaseFirestore.instance.collection('users');

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser!;
    CreateTeamModel createTeamModel = CreateTeamModel();
    TeamVTeamModel teamVteamModel = TeamVTeamModel();

    // writing all the values
    teamVteamModel.uid = FirebaseAuth.instance.currentUser!.uid;
    teamVteamModel.fullName = userDocs['fullName'];
    teamVteamModel.email = userDocs['email'];
    teamVteamModel.phoneNumber = userDocs['phoneNumber'];
    teamVteamModel.status = 'idle';
    createTeamModel.uid = FirebaseAuth.instance.currentUser!.uid;
    createTeamModel.userName = userDocs['fullName'];
    createTeamModel.userContact = userDocs['phoneNumber'];
    createTeamModel.team = 'Pending';
    createTeamModel.playerUid = widget.documentId;
    createTeamModel.playerName = playerDocs['fullName'];
    createTeamModel.playerContact = playerDocs['phoneNumber'];
    createTeamModel.date =
        '${DateTime.now().day}:${DateTime.now().month}:${DateTime.now().year}/${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    createTeamModel.userEmail = userDocs['email'];
    createTeamModel.playerEmail = playerDocs['email'];

    await firebaseFirestore
        .collection('CreateTeam')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyTeam')
        .doc()
        .set(createTeamModel.toMap());
    Fluttertoast.showToast(msg: "Request sent!");
    await firebaseFirestore
        .collection('invitations')
        .doc()
        .set(createTeamModel.toMap()); 
        print('hahah');
            // Fluttertoast.showToast(msg: "Request sent!");
    await firebaseFirestore
        .collection('teams')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(teamVteamModel.toMap()); 
        print('hahah');

    Navigator.pop(context);
  }
  // String documentID = " ";
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
        FirebaseFirestore.instance.collection('users');
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
                                "${data['fullName']}",
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
                                  leading: Icon(
                                    Icons.category_outlined,
                                    color: Colors.white,
                                  ),
                                  title: Text("${data['category']}",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                  leading: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                  ),
                                  title: Text("${data['email']}",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                    leading: Icon(Icons.stadium_outlined,
                                        color: Colors.white),
                                    title: Text(
                                      "${data['matches']}",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                    leading: Icon(Icons.run_circle_outlined,
                                        color: Colors.white),
                                    title: Text(
                                      "${data['runs']}",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                    leading: Icon(Icons.sports_cricket_outlined,
                                        color: Colors.white),
                                    title: Text(
                                      "${data['wickets']}",
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
                                postDetailsToFirestore();
                                updateTeam();
                              },
                              color: Colors.white,
                              height: 45,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Send Request",
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
  Future updateTeam() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.documentId)
        .update({'team': 'Pending'}).then((value) => print('success'));
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

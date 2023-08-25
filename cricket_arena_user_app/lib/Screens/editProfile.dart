// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_app/Screens/grounds.dart';
import 'package:user_app/Screens/home.dart';

class EditProfile extends StatefulWidget {
  final String documentId;
  EditProfile({Key? key, required this.documentId}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var size, height, width;
  final TextEditingController nameUpdateEditingController =
      new TextEditingController();
      final TextEditingController phoneNumberUpdateEditingController =
      new TextEditingController();
      final TextEditingController runsUpdateEditingController =
      new TextEditingController();
      final TextEditingController wicketsUpdateEditingController =
      new TextEditingController();
      final TextEditingController matchesUpdateEditingController =
      new TextEditingController();
      final TextEditingController teamEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final updateNameField = TextFormField(
        autofocus: false,
        controller: nameUpdateEditingController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          nameUpdateEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Update your name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

        final phoneNumberUpdateField = TextFormField(
        autofocus: false,
        controller: phoneNumberUpdateEditingController,
        keyboardType: TextInputType.phone,
        onSaved: (value) {
          phoneNumberUpdateEditingController.text = value!;
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11)
        ],
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Update your number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

        final matchesUpdateField = TextFormField(
        autofocus: false,
        controller: matchesUpdateEditingController,
        keyboardType: TextInputType.number,
        onSaved: (value) {
          matchesUpdateEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.numbers),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Update matches",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));


        final runsUpdateField = TextFormField(
        autofocus: false,
        controller: runsUpdateEditingController,
        keyboardType: TextInputType.number,
        onSaved: (value) {
          runsUpdateEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.numbers),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Update runs",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

final teamField = TextFormField(
        autofocus: false,
        controller: teamEditingController,
        keyboardType: TextInputType.number,
        onSaved: (value) {
          teamEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.numbers),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Update team",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

        final wicketsUpdateField = TextFormField(
        autofocus: false,
        controller: wicketsUpdateEditingController,
        keyboardType: TextInputType.number,
        onSaved: (value) {
          wicketsUpdateEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.numbers),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Update wickets",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    CollectionReference users =
        FirebaseFirestore.instance.collection('users');
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
          title: Text("EditProfile"),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(widget.documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Container(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                      
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.001),
                          ListTile(
                            title: Text("Name"),
                            subtitle: Text("${data['fullName']}"),
                            trailing: InkWell(
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color.fromARGB(214, 102, 50, 98),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Update Name"),
                                    content: updateNameField,
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          if (nameUpdateEditingController
                                              .text.isEmpty) {
                                            Navigator.pushAndRemoveUntil(
                                                (this.context),
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfile(
                                                          documentId: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid,
                                                        )),
                                                (route) => false);
                                          } else if (nameUpdateEditingController
                                              .text.isNotEmpty) {
                                            updateName(nameUpdateEditingController.text);
                                            Fluttertoast.showToast(
                                                msg: 'Name updated successfully');
                                            Navigator.of(ctx).pop();
                                          }
                                        },
                                        child: Text("Ok"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Divider(color: Colors.grey[500]),
                          ),
                          ListTile(
                            title: Text("Phone Number"),
                            subtitle: Text("${data['phoneNumber']}"),
                            trailing: InkWell(
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color.fromARGB(214, 102, 50, 98),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Update Phone Number"),
                                    content: phoneNumberUpdateField,
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          if (phoneNumberUpdateEditingController
                                              .text.isEmpty) {
                                            Navigator.pushAndRemoveUntil(
                                                (this.context),
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfile(
                                                          documentId: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid,
                                                        )),
                                                (route) => false);
                                          } else if (phoneNumberUpdateEditingController
                                              .text.isNotEmpty) {
                                            updatePhoneNumber(phoneNumberUpdateEditingController.text);
                                            Fluttertoast.showToast(
                                                msg: 'Phone Number updated successfully');
                                            Navigator.of(ctx).pop();
                                          }
                                        },
                                        child: Text("Ok"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Divider(color: Colors.grey[500]),
                          ),
                          ListTile(
                            title: Text("Matches"),
                            subtitle: Text("${data['matches']}"),
                            trailing: InkWell(
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color.fromARGB(214, 102, 50, 98),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Update Matches"),
                                    content: matchesUpdateField,
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          if (matchesUpdateEditingController
                                              .text.isEmpty) {
                                            Navigator.pushAndRemoveUntil(
                                                (this.context),
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfile(
                                                          documentId: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid,
                                                        )),
                                                (route) => false);
                                          } else if (matchesUpdateEditingController
                                              .text.isNotEmpty) {
                                            updateMatches(matchesUpdateEditingController.text);
                                            Fluttertoast.showToast(
                                                msg: 'Matches updated successfully');
                                            Navigator.of(ctx).pop();
                                          }
                                        },
                                        child: Text("Ok"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Divider(color: Colors.grey[500]),
                          ),
                          ListTile(
                            title: Text("Runs"),
                            subtitle: Text("${data['runs']}"),
                            trailing: InkWell(
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color.fromARGB(214, 102, 50, 98),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Update Runs"),
                                    content: runsUpdateField,
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          if (runsUpdateEditingController
                                              .text.isEmpty) {
                                            Navigator.pushAndRemoveUntil(
                                                (this.context),
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfile(
                                                          documentId: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid,
                                                        )),
                                                (route) => false);
                                          } else if (runsUpdateEditingController
                                              .text.isNotEmpty) {
                                            updateRuns(runsUpdateEditingController.text);
                                            Fluttertoast.showToast(
                                                msg: 'Runs updated successfully');
                                            Navigator.of(ctx).pop();
                                          }
                                        },
                                        child: Text("Ok"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Divider(color: Colors.grey[500]),
                          ),
                          ListTile(
                            title: Text("Wickets"),
                            subtitle: Text("${data['wickets']}"),
                            trailing: InkWell(
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color.fromARGB(214, 102, 50, 98),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Update Wickets"),
                                    content: wicketsUpdateField,
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          if (wicketsUpdateEditingController
                                              .text.isEmpty) {
                                            Navigator.pushAndRemoveUntil(
                                                (this.context),
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfile(
                                                          documentId: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid,
                                                        )),
                                                (route) => false);
                                          } else if (wicketsUpdateEditingController
                                              .text.isNotEmpty) {
                                            updateWickets(wicketsUpdateEditingController.text);
                                            Fluttertoast.showToast(
                                                msg: 'Wickets updated successfully');
                                            Navigator.of(ctx).pop();
                                          }
                                        },
                                        child: Text("Ok"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Divider(color: Colors.grey[500]),
                          ),
                          ListTile(
                            title: Text("Team"),
                            subtitle: Text("${data['team']}"),
                            trailing: InkWell(
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color.fromARGB(214, 102, 50, 98),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Update team"),
                                    content: teamField,
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          if (teamEditingController
                                              .text.isEmpty) {
                                            Navigator.pushAndRemoveUntil(
                                                (this.context),
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfile(
                                                          documentId: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid,
                                                        )),
                                                (route) => false);
                                          } else if (runsUpdateEditingController
                                              .text.isNotEmpty) {
                                            updateTeam(runsUpdateEditingController.text);
                                            Fluttertoast.showToast(
                                                msg: 'Team updated successfully');
                                            Navigator.of(ctx).pop();
                                          }
                                        },
                                        child: Text("Ok"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Divider(color: Colors.grey[500]),
                          ),
                          ListTile(
                            title: Text("Email"),
                            subtitle: Text("${data['email']}"),
                            onTap: () {},
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Divider(color: Colors.grey[500]),
                          ),
                          ListTile(
                            title: Text("Password"),
                            subtitle: Text("******"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Divider(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 35,
                        blurRadius: 10,
                        offset: Offset(4, 4),
                      ),
                    ]),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            // fixedColor: Color.fromARGB(214, 102, 50, 98),
            currentIndex: 2,
            selectedItemColor: Color.fromARGB(214, 102, 50, 98),
            unselectedItemColor: Colors.black,
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

  Future updateName(updatename) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'fullName': updatename}).then((value) => print('success'));
  }
  Future updatePhoneNumber(updatephone) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'phoneNumber': updatephone}).then((value) => print('success'));
  }
  Future updateMatches(updatematches) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'matches': updatematches}).then((value) => print('success'));
  }
  Future updateRuns(updateruns) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'runs': updateruns}).then((value) => print('success'));
  }
  Future updateWickets(updatewickets) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'wickets': updatewickets}).then((value) => print('success'));
  }
  Future updateTeam(updateteam) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'team': updateteam}).then((value) => print('success'));
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
        context,
        MaterialPageRoute(
            builder: (context) => Grounds()));
  } else {}
}
// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ground_app/Screens/bookings.dart';
import 'package:ground_app/Screens/home.dart';

class Profile extends StatefulWidget {
  final String documentId;
  Profile({Key? key, required this.documentId}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var size, height, width;
  final TextEditingController nameUpdateEditingController =
      new TextEditingController();
      final TextEditingController phoneNumberUpdateEditingController =
      new TextEditingController();
      final TextEditingController priceUpdateEditingController =
      new TextEditingController();
      final TextEditingController descUpdateEditingController =
      new TextEditingController();
      final TextEditingController locationUpdateEditingController =
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

        final locationUpdateField = TextFormField(
        autofocus: false,
        controller: locationUpdateEditingController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          locationUpdateEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Update ground location",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));


        final priceUpdateField = TextFormField(
        autofocus: false,
        controller: priceUpdateEditingController,
        keyboardType: TextInputType.phone,
        onSaved: (value) {
          priceUpdateEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.money),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Update booking price",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));


        final descUpdateField = TextFormField(
        autofocus: false,
        controller: descUpdateEditingController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          descUpdateEditingController.text = value!;
        },
        maxLines: 8,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98),)),
          // prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Update your description",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    CollectionReference users =
        FirebaseFirestore.instance.collection('Grounds');
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
          title: Text("Account Details"),
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
                            subtitle: Text("${data['groundName']}"),
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
                                                        Profile(
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
                                                        Profile(
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
                            title: Text("Location"),
                            subtitle: Text("${data['location']}"),
                            trailing: InkWell(
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color.fromARGB(214, 102, 50, 98),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Update Location"),
                                    content: locationUpdateField,
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          if (locationUpdateEditingController
                                              .text.isEmpty) {
                                            Navigator.pushAndRemoveUntil(
                                                (this.context),
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                          documentId: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid,
                                                        )),
                                                (route) => false);
                                          } else if (locationUpdateEditingController
                                              .text.isNotEmpty) {
                                            updateLocation(locationUpdateEditingController.text);
                                            Fluttertoast.showToast(
                                                msg: 'Location updated successfully');
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
                            title: Text("Booking Price"),
                            subtitle: Text("${data['price']}"),
                            trailing: InkWell(
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color.fromARGB(214, 102, 50, 98),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Update Booking Price"),
                                    content: priceUpdateField,
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          if (priceUpdateEditingController
                                              .text.isEmpty) {
                                            Navigator.pushAndRemoveUntil(
                                                (this.context),
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                          documentId: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid,
                                                        )),
                                                (route) => false);
                                          } else if (priceUpdateEditingController
                                              .text.isNotEmpty) {
                                            updatePrice(priceUpdateEditingController.text);
                                            Fluttertoast.showToast(
                                                msg: 'Price updated successfully');
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
                            title: Text("Description"),
                            subtitle: Text("${data['description']}"),
                            trailing: InkWell(
                              child: Icon(
                                Icons.edit_outlined,
                                color: Color.fromARGB(214, 102, 50, 98),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Update Description"),
                                    content: descUpdateField,
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          if (descUpdateEditingController
                                              .text.isEmpty) {
                                            Navigator.pushAndRemoveUntil(
                                                (this.context),
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                          documentId: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid,
                                                        )),
                                                (route) => false);
                                          } else if (descUpdateEditingController
                                              .text.isNotEmpty) {
                                            updateDescription(descUpdateEditingController.text);
                                            Fluttertoast.showToast(
                                                msg: 'Description updated successfully');
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
                  Icons.book_online_outlined,
                ),
                label: 'Bookings',
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
        .collection('Grounds')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'groundName': updatename}).then((value) => print('success'));
  }
  Future updatePhoneNumber(updatephone) async {
    FirebaseFirestore.instance
        .collection('Grounds')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'phoneNumber': updatephone}).then((value) => print('success'));
  }
  Future updateLocation(updatelocation) async {
    FirebaseFirestore.instance
        .collection('Grounds')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'location': updatelocation}).then((value) => print('success'));
  }
  Future updatePrice(updateprice) async {
    FirebaseFirestore.instance
        .collection('Grounds')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'price': updateprice}).then((value) => print('success'));
  }
  Future updateDescription(updatedesc) async {
    FirebaseFirestore.instance
        .collection('Grounds')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'description': updatedesc}).then((value) => print('success'));
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
        context, MaterialPageRoute(builder: (context) => Bookings()));
  } else {}
}
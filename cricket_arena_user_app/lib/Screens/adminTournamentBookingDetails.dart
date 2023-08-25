// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:user_app/Screens/bookAGround.dart';

class AdminTournamentBookingDetails extends StatefulWidget {
  final String documentId;
  AdminTournamentBookingDetails({Key? key, required this.documentId})
      : super(key: key);

  @override
  State<AdminTournamentBookingDetails> createState() => _AdminTournamentBookingDetailsState();
}

class _AdminTournamentBookingDetailsState extends State<AdminTournamentBookingDetails> {
  var size, height, width;

  bool isLoading = false;

  String? urlfinal = null;

  String? name = null;

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
        title: Text("Booked Tournament Profile"),
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
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       get_image(data['email']);
                                //     });
                                //   },
                                //   child: Center(
                                //     child: Column(
                                //       children: [
                                //         urlfinal != null
                                //             ? 
                                //             Image(image: NetworkImage(urlfinal!), width: MediaQuery.of(context).size.width,
                                //             height: MediaQuery.of(context).size.height*0.3, fit: BoxFit.fitWidth,)
                                //             : Text('View Profile..'),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                SizedBox(height: 5),
                                Center(
                                  child: Column(
                                    children: [
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
                                    "${data['rulesAndRegulations']}",
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
                                    leading: Icon(Icons.person,
                                        color: Colors.white),
                                    title: Text(
                                      "User Name: ${data['userName']}",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                  leading: Icon(
                                    Icons.money,
                                    color: Colors.white,
                                  ),
                                  title: Text("Rs: ${data['entryFees']}",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                  leading: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  title: Text("Location: ${data['location']}",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                    leading: Icon(Icons.timer,
                                        color: Colors.white),
                                    title: Text(
                                      "Time: ${data['time']}",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                    leading: Icon(Icons.phone,
                                        color: Colors.white),
                                    title: Text(
                                      "User Contact: ${data['userPhoneNumebr']}",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                          Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
                                final collection = FirebaseFirestore.instance.collection('tournamentBooking');
                            collection 
                                .doc(widget.documentId) // <-- Doc ID to be deleted. 
                                .delete() // <-- Delete
                                .then((_) => (Navigator.pop(context)))
                                .catchError((error) => print('Delete failed: $error'));
                                Fluttertoast.showToast(msg: 'Booking Deleted successfully');
                                },
                              color: Colors.white,
                              height: 45,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Delete Booking",
                                style: TextStyle(
                                    color: Color.fromARGB(214, 102, 50, 98),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 3),
                              ),
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
// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:user_app/Screens/bookAGround.dart';

class GroundRequestDetails extends StatefulWidget {
  final String documentId;
  GroundRequestDetails({Key? key, required this.documentId})
      : super(key: key);

  @override
  State<GroundRequestDetails> createState() => _GroundRequestDetailsState();
}

class _GroundRequestDetailsState extends State<GroundRequestDetails> {
  var size, height, width;

  bool isLoading = false;

  String? urlfinal = null;

  String? name = null;
  // String? email = null;

  get_image(email) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('groundImages/')
        .child(email)
        .child('DP.jpg');
    var url = await ref.getDownloadURL();
    print(url);
    setState(() {
      urlfinal = url;
    });
    return "Done";
  }

  // void intiState() {
  //   super.initState();

  //   workers.doc(widget.documentId).get().then((value) {
  //     get_image(value['email']).then((value) {
  //       setState(() {
  //         urlfinal = value;
  //       });
  //     });
  //   });
  // }

  CollectionReference workers =
      FirebaseFirestore.instance.collection('groundBookings');

  @override
  Widget build(BuildContext context) {
    // CollectionReference for worker drwaer single data
    // CollectionReference workers =
    //     FirebaseFirestore.instance.collection('employeesDetails');

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
        title: Text("Ground Profile"),
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
                      // get_image(data['email']);
                      // setState(() {
                      //   get_image(data['email']);
                      // });

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
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      get_image(data['email']);
                                    });
                                  },
                                  child: Center(
                                    child: Column(
                                      children: [
                                        urlfinal != null
                                            ? 
                                            // CircleAvatar(
                                            //     radius: 50.0,
                                            //     backgroundImage:
                                            //         NetworkImage(urlfinal!),
                                            //     backgroundColor:
                                            //         Colors.transparent,
                                            //   ),
                                            Image(image: NetworkImage(urlfinal!), width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height*0.3, fit: BoxFit.fitWidth,)
                                            : Text('View Profile..'),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${data['ground name']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      
                                    ],
                                  ),
                                ),
                                // SizedBox(height: 5),
                                Divider(color: Colors.grey),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${data['booking slot']}",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        "${data['booking day']}",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
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
                                  title: Text("${data['ground price']}",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                // ListTile(
                                //   leading: Icon(
                                //     Icons.reviews_outlined,
                                //     color: Colors.white,
                                //   ),
                                //   title: const Text("Ratings",
                                //       style: TextStyle(color: Colors.white)),
                                //   subtitle: Text(
                                //       "${double.parse(data['rating']).toStringAsFixed(2)} / ${double.parse(data['noOfRating'])}",
                                //       style:
                                //           const TextStyle(color: Colors.white)),
                                // ),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                  leading: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  title: Text("${data['ground location']}",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Divider(color: Color.fromARGB(214, 102, 50, 98)),
                                ListTile(
                                    leading: Icon(Icons.phone,
                                        color: Colors.white),
                                    title: Text(
                                      "${data['ground contact']}",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            ),
                          ),
                              SizedBox(height: 10,),
                          Container(
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
                                    cancelledByUser();
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
  Future cancelledByUser() async {
    FirebaseFirestore.instance
        .collection('groundBookings')
        .doc(widget.documentId)
        .update({"status": "Cancelled"}).then(
            (value) => print("Success"));
  }
}
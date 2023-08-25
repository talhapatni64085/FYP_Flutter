// ignore_for_file: file_names
// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyMatchRequestDetails extends StatefulWidget {
  final String documentId;
  final bool isApprove;
  MyMatchRequestDetails({Key? key, required this.documentId, required this.isApprove}) : super(key: key);

  @override
  State<MyMatchRequestDetails> createState() => _MyMatchRequestDetailsState();
}

class _MyMatchRequestDetailsState extends State<MyMatchRequestDetails> {
  var size, height, width;

  bool isLoading = false;

  String? urlfinal = null;

  String? name = null;
  // String? email = null;

  get_image(email) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('userProfiles/')
        .child(email)
        .child('DP.jpg');
    var url = await ref.getDownloadURL();
    print(url);
    setState(() {
      urlfinal = url;
    });
    return "Done";
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference for worker drwaer single data
    CollectionReference workers =
        FirebaseFirestore.instance.collection('teamVsTeam');
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
        title: Text('Match Details'),
        
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
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: Colors.purple),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                      spreadRadius: 4)
                                ]),
                            child: Column(
                              children: [
                                
                                SizedBox(height: 5),
                                Center(
                                  child: Text(
                                    "${data['teamName']}",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                                // SizedBox(height: 5),
                                Divider(color: Colors.grey),
                                Center(
                                  child: Text(
                                    "Team Member Name: ${data['teamHeadName']}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),),
                                SizedBox(height: 5),
                                Divider(color: Colors.grey),
                                Center(
                                  child: Text(
                                    "Request status: ${data['status']}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height - 500,
                width: double.infinity,
                color: Colors.white,
                child: widget.isApprove == false ? SizedBox(): Column(
                  children: [
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
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
                          minWidth: double.infinity,
                          color: Colors.red,
                          height: 50,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Cancel Request",
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

  Future cancelledByUser() async {
    FirebaseFirestore.instance
        .collection('teamVsTeam')
        .doc(widget.documentId)
        .update({"status": "cancel"}).then(
            (value) => print('Success'));
  }
}
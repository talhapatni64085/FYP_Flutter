import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:user_app/Screens/matchRequestDetails.dart';
import 'package:user_app/Screens/myMatchRequestDetail.dart';

class MatchRequest extends StatefulWidget {
  @override
  State<MatchRequest> createState() => _MatchRequestState();
}

class _MatchRequestState extends State<MatchRequest> {
  Stream<QuerySnapshot>? order;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    final Stream<QuerySnapshot> orders = FirebaseFirestore.instance
        .collection('teamVsTeam')
        .where('teamUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('status', whereIn: ['Approved', 'pending', 'cancel'])
        .snapshots();

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
        title: Text('Match Requests'),
        
      ),
        body: StreamBuilder<QuerySnapshot>(
          stream: orders,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.size == 0) {
              return Center(child: Text('You have not sent request yet!'));
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      // height: 120,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                            spreadRadius: 1)
                      ]),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Team Name",
                                  ),
                                  Text(
                                    "${data['userTeamName']}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, right: 8.0),
                              child: Text(
                                  "Team Member Name: ${data['userName']}"),
                            ),
                          ],
                        ),
                        trailing: Text(data['status']),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MatchRequestDetails(
                                  documentId: document.id,
                                  isApprove: data['status'] == 'cancel' ? false : true,
                                )));
                  },
                );
              }).toList(),
            );
          },
        ),);
  }
}
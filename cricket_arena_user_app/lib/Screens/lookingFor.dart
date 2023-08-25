// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/Screens/createTeamDetail.dart';
import 'package:user_app/Screens/groundDetails.dart';
import 'package:user_app/Screens/lookingForDetail.dart';
import 'package:user_app/Screens/myPendingTournamentDetails.dart';
import 'package:user_app/Screens/pendingTournamentDetails.dart';
import 'package:user_app/Screens/editProfile.dart';
import 'package:user_app/Screens/tournamentDetails.dart';
import 'package:user_app/Screens/tournamentRequestDetails.dart';
import 'package:user_app/Screens/yourTournamentDetails.dart';

class LookingFor extends StatefulWidget {
  const LookingFor({Key? key}) : super(key: key);

  @override
  _LookingForState createState() => _LookingForState();
}

class _LookingForState extends State<LookingFor> {
  var size, height, width;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .snapshots();

  // TextEditingController _searchController = TextEditingController();
  QuerySnapshot? searchSnapshot;

  // function to search for users in Firestore
  // void searchUsers(String query) {
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .where("category", isEqualTo: query)
  //       .get()
  //       .then((snapshot) {
  //     setState(() {
  //       searchSnapshot = snapshot;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    
  final TextEditingController searchEditingController = new TextEditingController();

    final searchField = TextFormField(
        autofocus: false,
        controller: searchEditingController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          searchEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple)),
          suffixIcon: const Icon(Icons.search, color: Colors.purple,),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Search", focusColor: Colors.purple,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.purple)
          ),
        ));

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
        title: Text("Looking For"),
        // actions: [
        //   Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.only(right: 20),
        //         child: Text("Save"),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: searchField,
          ),
        //   TextField(
        //   controller: searchEditingController,
        //   decoration: InputDecoration(
        //     hintText: "Search...",
        //     hintStyle: TextStyle(color: Colors.black),
        //     border: InputBorder.none,
        //   ),
        //   style: TextStyle(color: Colors.black),
        //   onSubmitted: (query) {
        //     // searchUsers(query);
        //   },
        // ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: searchSnapshot != null ? ListView.builder(
              itemCount: searchSnapshot!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot user = searchSnapshot!.docs[index];
                return ListTile(
                  title: Text(user["fullName"]),
                  subtitle: Text('data'),
                );
              },
            ): 
            // // Container(
            //   color: Colors.red,
            //   height: 300,
            // )
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
            
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.size == 0) {
                  return Center(child: Text('List is empty'));
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
                              leading: Icon(Icons.person, size: 50,),
                              // Image(
                              //   image: AssetImage('assets/logo_1.png'),
                              // ),
                              title: Text(data['fullName']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['phoneNumber']),
                                  Text(data['category']),
                                ],
                              ),
                              // trailing: Checkbox(value: , onChanged: (),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LookingForDetail(
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
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/Screens/lookingForDetail.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .snapshots();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String searchQuery = '';
  List<DocumentSnapshot>? searchResults;

  Future<List<DocumentSnapshot>> searchDocuments(String searchText) async {
    final QuerySnapshot snapshot = await firestore
        .collection('users')
        .where('fullName', isEqualTo: searchText)
        .get();

    return snapshot.docs;
  }

  void search() async {
    if (searchQuery.isNotEmpty) {
      final List<DocumentSnapshot> results = await searchDocuments(searchQuery);
      setState(() {
        searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        // TextField(
        //   onChanged: (value) => searchQuery = value,
        //   onSubmitted: (value) => search(),
        //   decoration: InputDecoration(
        //     hintText: 'Search', focusColor: Colors.white, fillColor: Colors.white, hoverColor: Colors.white,
        //     suffixIcon: IconButton(
        //       icon: Icon(Icons.search, color: Colors.white,),
        //       onPressed: dispose,
        //     ),
        //   ),
        // ),
      ),
      body: searchQuery.isNotEmpty ? ListView.builder(
        itemCount: searchResults?.length ?? 0,
        itemBuilder: (context, index) {
          final data = searchResults![index];
          // Build your UI using the document data
          if (searchQuery != searchQuery) {
            Text('please write correct name');
          }
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
                                          documentId: data.id,
                                        )));
                          },
                        ),
                      ),
                    );
        },
      ) : StreamBuilder<QuerySnapshot>(
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
    );
  }
}
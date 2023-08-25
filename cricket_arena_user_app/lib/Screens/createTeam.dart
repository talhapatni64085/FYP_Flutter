// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:user_app/Screens/Model/teamVteamModel.dart';
import 'package:user_app/Screens/Model/userModel.dart';
import 'package:user_app/Screens/createTeamDetail.dart';
import 'package:user_app/Screens/profile.dart';
class CreateTeam extends StatefulWidget {
  const CreateTeam({Key? key}) : super(key: key);

  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  final searchEditingController = new TextEditingController();
  TextEditingController createTeamEditingController = new TextEditingController();
  // List checkboxStatus = [];
  bool _checked = false;
  var size, height, width;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('team',isEqualTo: '-')
      .snapshots();

      
  var userDocs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readUser().then((value) => {
          setState(() {
            userDocs = value;
          })
        });
  }
  @override
  Widget build(BuildContext context) {
         postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    TeamVTeamModel teamVteamModel = TeamVTeamModel();

    // writing all the values
    teamVteamModel.uid = FirebaseAuth.instance.currentUser!.uid;
    teamVteamModel.fullName = userDocs['fullName'];
    teamVteamModel.teamName = createTeamEditingController.text;
    teamVteamModel.email = userDocs['email'];
    teamVteamModel.phoneNumber = userDocs['phoneNumber'];
    teamVteamModel.status = 'idle';

    await firebaseFirestore
        .collection('teams')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(teamVteamModel.toMap()); 
        print('hahah');

    // Navigator.pop(context);
  }

  // var playerList = Stream<List<QuerySnapshot>>[];
  // Stream<QuerySnapshot> serach = FirebaseFirestore.instance
  //     .collection('users').snapshots();
  // void filterPlayer(String playerName){
  //   List<QuerySnapshot<serach>> results = [];
  //   if(playerName.isEmpty)
  //   {
  //     results = playerList;
  //   }
  //   else{
  //     results = playerList.where((element) => element.toString().toLowerCase().contains(playerName.toLowerCase()));
  //   }
  // }

  Future<QuerySnapshot>? postDocLists;
  


  // String userNameText = '';

  // initSearch(String playerName){
  //   postDocLists = FirebaseFirestore.instance
  //   .collection('users')
  //   .where('fullName', isGreaterThanOrEqualTo: playerName)
  //   .get();

  //   setState(() {
  //     postDocLists;
  //   });
  // }

//   List<Need> yourNeeds=[];
// await firestore.collection("Need")
//         .getDocuments()
//         .then((QuerySnapshot snapshot) {
//        snapshot.documents.forEach((f) {
//             Needs obj= new Need();
       
//         obj.field1=f.data['field1'].toString();
//         obj.field2=f.data['field2'].toDouble();

//         //Adding value to your Need list
//         yourNeeds.add(obj);
// }););

    final List<SearchUser> list = [];

  getUsers() async {
    final snapshot = await FirebaseDatabase.instance.ref('users').get();

    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final user = SearchUser.fromMap(value);

      list.add(user);
    });
  }

  // void SerachMethod(String text) async{
  //   DatabaseReference searchRef = FirebaseDatabase.instance.ref().child('users');
  //   searchRef.once().then((DataSnapshot snapshot))
  // }
  // List searchResult = [];

  // void searchFromFirebase(String query) async{
  //   final result = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('fullName', arrayContains: query)
  //       .get();

  //   setState(() {
  //     searchResult = result.docs.map((e) => e.data()).toList();
  //   });
  // }
    
    final teamField = TextFormField(
        autofocus: false,
        controller: createTeamEditingController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          createTeamEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Team Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));


    final searchField = TextFormField(
        autofocus: false,
        controller: searchEditingController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          searchEditingController.text = value!;
        },
        onChanged: (value){
          // SearchPlayerController.filterPlayer(value);
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          suffixIcon: const Icon(Icons.search, color: Colors.white,),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Search", focusColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white)
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
        title: searchField,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.size == 0) {
            return Center(child: Text('Your tournament list is empty'));
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
                        title: Text(data['fullName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['category']),
                          ],
                        ),
                        // trailing: Checkbox(
                        //         value: _checked,
                        //         onChanged: (bool? value) {
                        //           // print(checkboxStatus.length);
                        //           setState((() {
                        //             _checked =
                        //             !_checked;
                        //           }));
                        //         },
                        //         checkColor: Colors.white,
                        //       )
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateTeamDetails(
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
      
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.black,
        onPressed: () {
          showDialog(context: context, builder: ((context) => AlertDialog(
            title: Text('Create Team'),
            content: teamField,
            
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          if (createTeamEditingController
                                              .text.isEmpty) {
                                            Navigator.pop(context);
                                          } else if (createTeamEditingController
                                              .text.isNotEmpty) {
                                            postDetailsToFirestore();
                                            Fluttertoast.showToast(
                                                msg: 'Team created successfully').then((value) => Navigator.pop(context));
                                            
                                          }
                                        },
                                        child: Text("Ok"),
                                      ),
                                    ],
          )));
        },
        icon: Icon(Icons.add, color: Colors.white, size: 30,),
        label: Text('Create Team', style: TextStyle(
          color: Colors.white
        ),),
      )
    );
  }Future readUser() async {
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

}

class SearchUser {

  final String name;

  const SearchUser({
    required this.name,
  });

  factory SearchUser.fromMap(Map<dynamic, dynamic> map) {
    return SearchUser(
      name: map['name'] ?? '',
    );
  }
}


class SearchUserModel {
  String? uid;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? password;
  String? category;
  String? matches;
  String? runs;
  String? wickets;
  String? team;

  SearchUserModel({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.password,
    this.category,
    this.matches,
    this.runs,
    this.wickets,
    this.team,
  });

  // receiving data from server
  factory SearchUserModel.fromMap(map) {
    return SearchUserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      category: map['category'],
      matches: map['matches'],
      runs: map['runs'],
      wickets: map['wickets'],
      team: map['team'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'password': password,
      'category': category,
      'matches': matches,
      'runs': runs,
      'wickets': wickets,
      'team': team,
    };
  }

  void add(values) {}
}


class SearchPlayerController extends GetxController with GetSingleTickerProviderStateMixin{
  var playerList = <SearchUserModel>[].obs;
  @override
  void filterPlayer(String playeName){
    Iterable<SearchUserModel> result = [];
    if (playeName.isEmpty) {
      result = playerList;
    }
    else{
      result = playerList
      .where((element) => 
      element.fullName
      .toString()
      .toLowerCase()
      .contains(playeName.toLowerCase()))
      .toList();
    }
  }
}
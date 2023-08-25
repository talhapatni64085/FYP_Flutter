// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as Firebase_Storage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_app/Screens/Auth/login.dart';
import 'package:user_app/Screens/liveScore.dart';
import 'package:user_app/Screens/matchRequests.dart';
import 'package:user_app/Screens/myMatchRequest.dart';
import 'package:user_app/Screens/searchingTest.dart';
import 'package:user_app/Screens/teamVsTeam.dart';
import 'package:user_app/Screens/aboutUs.dart';
import 'package:user_app/Screens/completedTournaments.dart';
import 'package:user_app/Screens/groundHistory.dart';
import 'package:user_app/Screens/groundRequests.dart';
import 'package:user_app/Screens/grounds.dart';
import 'package:user_app/Screens/lookingFor.dart';
import 'package:user_app/Screens/myPendingTournaments.dart';
import 'package:user_app/Screens/myTeam.dart';
import 'package:user_app/Screens/myTournamentRequests.dart';
import 'package:user_app/Screens/pendingTournaments.dart';
import 'package:user_app/Screens/profile.dart';
import 'package:user_app/Screens/teamRequests.dart';
import 'package:user_app/Screens/termsAndConditions.dart';
import 'package:user_app/Screens/tournamentRequest.dart';
import 'package:user_app/Screens/tournaments.dart';
import 'package:user_app/Screens/yourTournaments.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String documentId = "";
  final auth = FirebaseAuth.instance.currentUser!;
  var size, height, width;

  String? urlfinal = null;
  String? name = null;
  String? email = null;


  Future liveScore() async{
    final request = await http.get(Uri.parse('https://api.cricapi.com/v1/currentMatches?apikey=4072bb4d-4388-4fa2-abb4-32085791fc17&offset=0'),
    );

    print(request.body);
  }

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("pass");
  }

  void initState() {
    super.initState();

    // name = auth.displayName;
    email = auth.email;
    documentId = auth.uid;
    get_image(email);
  }

  String? userName;
  String? contact;

  @override
  Widget build(BuildContext context) {
    
   
  
    // CollectionReference for user drwaer single data
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Color.fromARGB(214, 102, 50, 98),
          title: const Text("CRICKET ARENA", style: TextStyle(letterSpacing: 2),),
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false);
                },
                icon: const Icon(Icons.logout_outlined)),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  CarouselSlider(
                    items: [
                      //1st Image of Slider
                      Container(
                        margin: EdgeInsets.all(height * 0.02),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage("assets/Logo2.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      //2nd Image of Slider
                      Container(
                        margin: EdgeInsets.all(height * 0.02),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage("assets/Slider1.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      //3rd Image of Slider
                      Container(
                        margin: EdgeInsets.all(height * 0.02),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage("assets/Slider3.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],

                    //Slider Container properties
                    options: CarouselOptions(
                      height: height * 0.35,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 1000),
                      viewportFraction: 1.0,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.05, top: height * 0.01),
                        child: Text("Features",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      workersBTN1(context, "Looking For",
                          "assets/lookingforcricket.png", SearchScreen()),
                  SizedBox(
                    width: width * 0.02,
                  ),
                      workersBTN1(
                          context, "Live Score", "assets/livescore1.png", 
                          // EditProfile(documentId: user!.uid)
                          LiveScoreScreen()
                          ),
                  SizedBox(
                    width: width * 0.02,
                  ),

                          Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 5),
            spreadRadius: 1)
      ],
    ),
    child: ElevatedButton(
        onPressed: () {
          website_launchUrl();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/scorecard1.png", height: 85, width: 75),
              Text(
                "Score Card",
                style: TextStyle(color: Color.fromARGB(214, 102, 50, 98), fontSize: 15),
              ),
            ],
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      workersBTN1(
                          context, "Grounds", "assets/ground.png", Grounds()),
                  SizedBox(
                    width: width * 0.02,
                  ),
                      workersBTN1(context, "Tournaments", "assets/tournamentcricket.png",
                          Tournaments()),
                  SizedBox(
                    width: width * 0.02,
                  ),
                      workersBTN1(
                          context, "Team V Team", "assets/teamvsteam2.png", 
                          TeamVSTeam()),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  ],
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: FutureBuilder<DocumentSnapshot>(
            future: users.doc(documentId).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something Went wrong");
              }
              if (snapshot.hasData && !snapshot.data!.exists) {
                return ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text("Data does not exists"),
                      accountEmail: Text("Data does not exists"),
                    )
                  ],
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                // setState(() {
                userName = data['fullName'];
                contact = data['phoneNumber'];
                // });
                return ListView(
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home())).then((value) {
                        urlfinal = null;
                        setState(() {
                          get_image(email);
                        });
                      }),
                      child: urlfinal != null
                          ? UserAccountsDrawerHeader(
                              decoration:
                                  BoxDecoration(color: Color.fromARGB(0, 102, 50, 98)),
                              currentAccountPicture: CircleAvatar(
                                backgroundImage: NetworkImage(urlfinal!),
                                backgroundColor: Colors.transparent,
                              ),
                              accountName: Text("${userName}",
                                  style: TextStyle(color: Colors.black)),
                              accountEmail: Text("${data['email']}",
                                  style: TextStyle(color: Colors.black)),
                            )
                          : UserAccountsDrawerHeader(
                              decoration:
                                  BoxDecoration(color: Color.fromARGB(214, 102, 50, 98)),
                              currentAccountPicture: CircleAvatar(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                              accountName: Text("${data['fullName']}",
                                  style: TextStyle(color: Colors.black)),
                              accountEmail: Text("${data['email']}",
                                  style: TextStyle(color: Colors.black)),
                            ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("Tournament Requests"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TournamentRequests(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("My Completed Tournaments"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompletedTournaments(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("My Tournament Requests"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyTournamentRequests(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("Ground Requests"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroundRequests(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("Ground History"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroundHistory(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("My Pending Requests"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PendingTournaments(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("My Tournaments"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YourTournaments(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("My Pending Tournaments"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPendingTournaments(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("My Team"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyTeam(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("Team Requests"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeamRequests(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("My Match Requests"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyMatchRequests(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.approval_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("Match Requests"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MatchRequest(
                                    )));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.pending_actions_outlined,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      title: Text("Terms & Conditions"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsAndCondition(
                                    )));
                      },
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.announcement, color: Color.fromARGB(214, 102, 50, 98)),
                      title: Text("About Us"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(214, 102, 50, 98),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutUs(
                                    )));
                      },
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.logout_rounded,
                          color: Color.fromARGB(214, 102, 50, 98),
                        ),
                        title: Text("Log Out"),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(214, 102, 50, 98),
                        ),
                        onTap: () {
                          logout();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false);
                        }
                        )
                  ],
                );
              }
              return Text("Loading");
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            // fixedColor: Color.fromARGB(214, 102, 50, 98),
            currentIndex: 0,
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
            ]), 
      );
      
  }
}

final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;
btn(i, context) {
  if (i == 0) {
  } else if (i == 1) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Grounds()));
  } else {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile()));
  }
      
}
 final Uri web_url = Uri.parse('https://c5e7-223-123-113-135.ngrok-free.app');
Future<void> website_launchUrl() async {
  if (!await launchUrl(web_url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $web_url';
  }
}

Container workersBTN1(BuildContext context, txt, img, page) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 5),
            spreadRadius: 1)
      ],
    ),
    child: ElevatedButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(img, height: 85, width: 75),
              Text(
                txt,
                style: TextStyle(color: Color.fromARGB(214, 102, 50, 98), fontSize: 14),
              ),
            ],
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  );
  
}

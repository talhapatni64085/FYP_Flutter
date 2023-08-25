import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:user_app/Screens/Auth/login.dart';
import 'package:user_app/Screens/adminGroundBooking.dart';
import 'package:user_app/Screens/adminGrounds.dart';
import 'package:user_app/Screens/adminTeams.dart';
import 'package:user_app/Screens/adminTournamentBooking.dart';
import 'package:user_app/Screens/adminTournaments.dart';
import 'package:user_app/Screens/adminUsers.dart';



class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  var size, height, width;
  Future logout() async {
    await FirebaseAuth.instance.signOut();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove("email");
    // prefs.remove("pass");
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(214, 102, 50, 98),
        leading: Text(''),
        title: Center(child: Text('Admin')),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(title: Text("Hello,", style: TextStyle(fontSize: 22),), subtitle: Text("Admin", style: TextStyle(fontSize: 24),),),
          SizedBox(
            height: height*0.01,
          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 16,
      children: [
        StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1.5,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminGrounds()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(2, 2),
                                      
                                    )
                                  ]),
          child: Center(child: Text(
                                  "Grounds",
                                  style: TextStyle(
                                      color: Color.fromARGB(214, 102, 50, 98),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      // letterSpacing: 3
                                      ),
                                ),),
        ),
      ),
        ),
        StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1.5,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminTournaments()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(2, 2),
                                    )
                                  ]),
          child: Center(child: Text(
                                  "Tournaments",
                                  style: TextStyle(
                                      color: Color.fromARGB(214, 102, 50, 98),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      // letterSpacing: 3
                                      ),
                                ),),
        ),
      ),
        ),
        StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1.5,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminGroundBooking()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(2, 2),
                                      
                                    )
                                  ]),
          child: Center(child: Text(
                                  "Ground Bookings",
                                  style: TextStyle(
                                      color: Color.fromARGB(214, 102, 50, 98),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      // letterSpacing: 3
                                      ),
                                ),),
        ),
      ),
        ),
        StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1.5,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminTournamentBooking()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(2, 2),
                                      
                                    )
                                  ]),
          child: Center(
            child: Text(
                                    "Tournament Bookings",
                                    style: TextStyle(
                                        color: Color.fromARGB(214, 102, 50, 98),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        ),
                                  ),
          ),
        ),
      ),
        ),
        StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1.5,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminUsers()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(2, 2),
                                      
                                    )
                                  ]),
          child: Center(child: Text(
                                  "Users",
                                  style: TextStyle(
                                      color: Color.fromARGB(214, 102, 50, 98),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      // letterSpacing: 3
                                      ),
                                ),),
        ),
      ),
        ),
        StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1.5,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminTeams()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(2, 2),
                                      
                                    )
                                  ]),
          child: Center(child: Text(
                                  "Teams",
                                  style: TextStyle(
                                      color: Color.fromARGB(214, 102, 50, 98),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      // letterSpacing: 3
                                      ),
                                ),),
        ),
      ),
        ),
      ],
      ),
                          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
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
        title: Text("About Us"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Welcome to our cricket arena app! , we are passionate about providing the ultimate sports experience for our users. Our feature-rich platform offers seamless Ground Booking, enabling you to reserve your preferred sports and recreational venues hassle-free. Organize and manage exciting tournaments with just a few clicks through our Create Tournament feature, while Live Scores keep you updated in real-time. Looking for players to join your team? Our app connects you with like-minded athletes. You can even Create Teams and build a winning squad. Embrace the joy of sports with cricket arena, where excitement and convenience go hand in hand.")),
        ],
      ),
    );
  }
}
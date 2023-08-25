import 'package:flutter/material.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
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
        title: Text("Terms And Conditions"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("The Cricket Arena App, offered enables Users to conveniently book sports and recreational facilities. By accepting these Terms, Users agree to comply with all applicable laws and regulations while using the App. The App charges a 10% booking fee on the total reservation amount to cover service costs. Payments are securely processed through the App, and Users' privacy is protected as per the Privacy Policy. While cricket arena strives to provide accurate information, it is not liable for any damages or disputes arising from the use of the App or the condition of the Grounds. Users must adhere to the respective Grounds' policies and rules.")),
        ],
      ),
    );
  }
}
// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:user_app/Screens/Auth/login.dart';
import 'package:user_app/Screens/Model/tournamentModel.dart';
import 'package:user_app/Screens/Model/userModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as Firebase_Storage;
import 'package:user_app/Screens/home.dart';

class AddTournament extends StatefulWidget {
  const AddTournament({Key? key}) : super(key: key);

  @override
  _AddTournamentState createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  @override
  void initState() {
  }
  // for password visible or not

  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameEditingController = new TextEditingController();
  final locationEditingController = new TextEditingController();
  final entryFeesEditingController = new TextEditingController();
  final noOfTeamsEditingController = new TextEditingController();
  final rulesNRegulationEditingController = new TextEditingController();
  final timeEditingController = new TextEditingController();

  postDetailsToFirestore() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    TournamentModel tournamentModel = TournamentModel();

    // writing all the values
    tournamentModel.tournamentName = nameEditingController.text;
    tournamentModel.uid = user!.uid;
    tournamentModel.location = locationEditingController.text;
    tournamentModel.entryFees = entryFeesEditingController.text;
    tournamentModel.numberOfTeams = noOfTeamsEditingController.text;
    tournamentModel.rulesAndRegulations = rulesNRegulationEditingController.text;
    tournamentModel.time = timeEditingController.text;
    tournamentModel.status = '-';

    await firebaseFirestore
        .collection("tournaments")
        .doc(user.uid)
        .set(tournamentModel.toMap());
    Fluttertoast.showToast(msg: "Tournament added successfully");

    Navigator.pushAndRemoveUntil(
        (this.context),
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }
  
  @override
  Widget build(BuildContext context) {
    //first name field
    final tournamentNameField = TextFormField(
        autofocus: false,
        controller: nameEditingController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Tournament Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //first name field
    final locationField = TextFormField(
        autofocus: false,
        controller: locationEditingController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          locationEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: const Icon(Icons.location_on),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Tournament Location",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

        //first name field
    final entryFeesField = TextFormField(
        autofocus: false,
        controller: entryFeesEditingController,
        keyboardType: TextInputType.phone,
        onSaved: (value) {
          entryFeesEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: const Icon(Icons.money),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Entry Fees",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

        //first name field
    final numberOfTeamsField = TextFormField(
        autofocus: false,
        controller: noOfTeamsEditingController,
        keyboardType: TextInputType.phone,
        onSaved: (value) {
          noOfTeamsEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: const Icon(Icons.numbers),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Total number of teams",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

      //first name field
    final rulesAndRegulationField = TextFormField(
        autofocus: false,
        controller: rulesNRegulationEditingController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          rulesNRegulationEditingController.text = value!;
        },
        maxLines: 4,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          // prefixIcon: const Icon(Icons.text_fields_rounded),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Rules and regulations",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

        //first name field
    final timeField = TextFormField(
        autofocus: false,
        controller: timeEditingController,
        keyboardType: TextInputType.text,
        onSaved: (value) {
          timeEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(214, 102, 50, 98))),
          prefixIcon: const Icon(Icons.punch_clock),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Tournament Time",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));




    //add button
    final addButton = Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 10,
          offset: const Offset(2, 2),
        )
      ]),
      child: MaterialButton(
        onPressed: () {
          if (nameEditingController.text.isEmpty &&
              locationEditingController.text.isEmpty&&
              entryFeesEditingController.text.isEmpty&&
              noOfTeamsEditingController.text.isEmpty&&
              rulesNRegulationEditingController.text.isEmpty) {
            Fluttertoast.showToast(msg: "Information is not completed");
          } else {
            postDetailsToFirestore();
          }
        },
        minWidth: double.infinity,
        color: Color.fromARGB(214, 102, 50, 98),
        height: 50,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          "Add Tournament",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(214, 102, 50, 98),
        leading: Icon(
          Icons.arrow_back,
          color: Color.fromARGB(0, 102, 50, 98),
        ),
        title: Center(child: Text('Add Tournament')),
        actions: [
          Icon(Icons.arrow_back_ios_new_sharp, color: Color.fromARGB(0, 102, 50, 98)),
          Icon(Icons.arrow_back_ios_new_sharp, color: Color.fromARGB(0, 102, 50, 98)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.only(top: 10),
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/tournamentcricket.png"),
                        fit: BoxFit.fitHeight),
                  ),
                ),
                const Text(
                  "Add Tournament",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height:10,
                ),
                tournamentNameField,
                SizedBox(
                  height:10,
                ),
                locationField,
                SizedBox(
                  height:10,
                ),
                entryFeesField,
                SizedBox(
                  height:10,
                ),
                numberOfTeamsField,
                SizedBox(
                  height:10,
                ),
                rulesAndRegulationField,
                SizedBox(
                  height:10,
                ),
                timeField,
                SizedBox(
                  height:20,
                ),
                
                addButton,
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

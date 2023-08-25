import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class hellooo extends StatefulWidget {
  @override
  _helloooState createState() => _helloooState();
}

class _helloooState extends State<hellooo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  
  // function to search for users in Firestore
  Stream<QuerySnapshot> searchUsers(String query) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("category", isEqualTo: query)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Form(
          key: _formKey,
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a search query.';
              }
              return null;
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _searchController.text.isEmpty
            ? null
            : searchUsers(_searchController.text),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final searchResults = snapshot.data!.docs;

          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final user = searchResults[index];
              return ListTile(
                title: Text(user["fullName"]),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _searchController.clear();
          }
        },
        child: Icon(Icons.clear),
      ),
    );
  }
}
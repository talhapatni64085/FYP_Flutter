import 'package:flutter/material.dart';

import 'apiModel.dart';

class LiveScoreScreen extends StatefulWidget {
  @override
  _LiveScoreScreenState createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  List<Data> liveScores = [];

  @override
  void initState() {
    super.initState();
    fetchLiveScores();
  }

  Future<void> fetchLiveScores() async {
    try {
      LiveScoreModel liveScoreModel = await LiveScoreModel(apikey: '4072bb4d-4388-4fa2-abb4-32085791fc17',
      data: liveScores, status: 'success',).fetchLiveScores();
      setState(() {
        liveScores = liveScoreModel.data;
      });
    } catch (e) {
      print('Failed to fetch live scores: $e');
    }
  }

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
        title: Text('Live Score'),
        
      ),
      body: ListView.builder(
        itemCount: liveScores.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10,),
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
              child: ListTile(
                title: Text(liveScores[index].name.isEmpty ? 'Data not found' : liveScores[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(liveScores[index].status.isEmpty ? 'Data not found' : liveScores[index].status, 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    Text(liveScores[index].matchType.isEmpty ? 'Data not found' : liveScores[index].matchType),
                  ],
                ),
                trailing: Text(liveScores[index].matchType),
              ),
            ),
          );
        },
      ),
    );
  }
}

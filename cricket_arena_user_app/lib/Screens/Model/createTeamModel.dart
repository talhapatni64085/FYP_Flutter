// Pehla email pass wala kam hai yh
// ignore_for_file: file_names

class CreateTeamModel {
  String? uid;
  String? userName;
  String? userContact;
  String? team;
  String? playerUid;
  String? playerName;
  String? playerContact;
  String? date;
  String? userEmail;
  String? playerEmail;

  CreateTeamModel({
    this.uid,
    this.userName,
    this.userContact,
    this.team,
    this.playerUid,
    this.playerName,
    this.playerContact,
    this.date,
    this.userEmail,
    this.playerEmail,
  });

  // receiving data from server
  factory CreateTeamModel.fromMap(map) {
    return CreateTeamModel(
      uid: map['uid'],
      userName: map['userName'],
      userContact: map['userContact'],
      playerName: map['playerName'],
      playerContact: map['playerContact'],
      team: map['team'],
      playerUid: map['playerUid'],
      date: map['date'],
      userEmail: map['userEmail'],
      playerEmail: map['playerEmail'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'userContact': userContact,
      'team': team,
      'playerUid': playerUid,
      'player name': playerName,
      'player contact': playerContact,
      'date': date,
      'userEmail': userEmail,
      'playerEmail': playerEmail,
    };
  }
}
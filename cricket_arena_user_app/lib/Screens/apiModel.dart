import 'package:http/http.dart' as http;
import 'dart:convert';

class LiveScoreModel {
  final String apikey;
  final List<Data> data;
  final String status;
  // final Info info;

  LiveScoreModel({required this.apikey, required this.data, required this.status});

  factory LiveScoreModel.fromJson(Map<String, dynamic> json) {
    return LiveScoreModel(
      apikey: json['apikey'],
      data: List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
      status: json['status'],
      // info: Info.fromJson(json['info']),
    );
  }

  Future<LiveScoreModel> fetchLiveScores() async {
    final response = await http.get(Uri.parse('https://api.cricapi.com/v1/currentMatches?apikey=4072bb4d-4388-4fa2-abb4-32085791fc17&offset=0'));
    if (response.statusCode == 200) {
      return LiveScoreModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch live scores');
    }
  }
}

class Data {
  final String id;
  final String name;
  final String matchType;
  final String status;
  final String venue;
  final String date;
  final String dateTimeGMT;
  final List<String> teams;
  final List<TeamInfo> teamInfo;
  final List<Score> score;
  final String seriesId;
  final bool fantasyEnabled;
  final bool bbbEnabled;
  final bool hasSquad;
  final bool matchStarted;
  final bool matchEnded;

  Data({
    required this.id,
    required this.name,
    required this.matchType,
    required this.status,
    required this.venue,
    required this.date,
    required this.dateTimeGMT,
    required this.teams,
    required this.teamInfo,
    required this.score,
    required this.seriesId,
    required this.fantasyEnabled,
    required this.bbbEnabled,
    required this.hasSquad,
    required this.matchStarted,
    required this.matchEnded,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      matchType: json['matchType'],
      status: json['status'],
      venue: json['venue'],
      date: json['date'],
      dateTimeGMT: json['dateTimeGMT'],
      teams: List<String>.from(json['teams'].map((x) => x)),
      teamInfo: List<TeamInfo>.from(json['teamInfo'].map((x) => TeamInfo.fromJson(x))),
      score: List<Score>.from(json['score'].map((x) => Score.fromJson(x))),
      seriesId: json['series_id'],
      fantasyEnabled: json['fantasyEnabled'],
      bbbEnabled: json['bbbEnabled'],
      hasSquad: json['hasSquad'],
      matchStarted: json['matchStarted'],
      matchEnded: json['matchEnded'],
    );
  }
}

class TeamInfo {
  final String name;
  final String shortname;
  final String img;

  TeamInfo({
    required this.name,
    required this.shortname,
    required this.img,
  });

  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    return TeamInfo(
      name: json['name'],
      shortname: json['shortname'],
      img: json['img'],
    );
  }
}

class Score {
  final int r;
  final int w;
  final double o;
  final String inning;

  Score({
    required this.r,
    required this.w,
    required this.o,
    required this.inning,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      r: json['r'],
      w: json['w'],
      o: json['o'].toDouble(),
      inning: json['inning'],
    );
  }
}

class Info {
  final int hitsToday;
  final int hitsUsed;
  final int hitsLimit;
  final int credits;
  final int server;
  final int offsetRows;
  final int totalRows;
  final double queryTime;
  final int s;
  final int cache;

  Info({
    required this.hitsToday,
    required this.hitsUsed,
    required this.hitsLimit,
    required this.credits,
    required this.server,
    required this.offsetRows,
    required this.totalRows,
    required this.queryTime,
    required this.s,
    required this.cache,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      hitsToday: json['hitsToday'],
      hitsUsed: json['hitsUsed'],
      hitsLimit: json['hitsLimit'],
      credits: json['credits'],
      server: json['server'],
      offsetRows: json['offsetRows'],
      totalRows: json['totalRows'],
      queryTime: json['queryTime'],
      s: json['s'],
      cache: json['cache'],
    );
  }
}

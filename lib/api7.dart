import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

class api7 extends StatefulWidget {
  const api7({Key? key}) : super(key: key);

  @override
  _api7State createState() => _api7State();
}

class _api7State extends State<api7> {

  List list = [];

  getAllData() async {
    var url = Uri.parse('https://api.jikan.moe/v3/search/anime?q=naruto');
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    Map m = jsonDecode(response.body);

    list = m['results'];
    print("${list}");

    //List<api_7> api_7list = list.map((e) => api_7.fromJson(e)).toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("API 7"),
        // actions: [
        //   TextButton(onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) {
        //       return  api8();
        //     },));
        //   }, child: Text("go to next",style: TextStyle(fontSize: 22,color: Colors.black)),)
        // ],
      ),
      body: FutureBuilder(
        future: getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List list = snapshot.data as List;

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  String? url = list[index]['image_url'];
                  return Container(
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(4),
                    child: ListTile(
                      tileColor: Colors.black12,
                     // trailing: Image.network(url!),
                        leading: GFImageOverlay(
                          height: 50,
                          width: 50,
                          shape: BoxShape.circle,
                          image: NetworkImage(url!),
                          boxFit: BoxFit.cover,
                        ),

                      title: Text("${list[index]['title']}",
                          style: TextStyle(fontSize: 22)),
                      // subtitle: Text("${list[index]['airing']}",
                      //     style: TextStyle(fontSize: 22)),
                    ),
                  );
                },
              );
            }
            return Center(child: Text("No Data found"));
          }
          return Center(
            child: GFLoader(type: GFLoaderType.circle),
          );
        },
      ),
    );
  }
}

class api_7 {
  int? malId;
  String? url;
  String? imageUrl;
  String? title;
  bool? airing;
  String? synopsis;
  String? type;
  int? episodes;
  double? score;
  String? startDate;
  String? endDate;
  int? members;
  String? rated;

  api_7(
      {this.malId,
        this.url,
        this.imageUrl,
        this.title,
        this.airing,
        this.synopsis,
        this.type,
        this.episodes,
        this.score,
        this.startDate,
        this.endDate,
        this.members,
        this.rated});

  api_7.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    imageUrl = json['image_url'];
    title = json['title'];
    airing = json['airing'];
    synopsis = json['synopsis'];
    type = json['type'];
    episodes = json['episodes'];
    score = json['score'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    members = json['members'];
    rated = json['rated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    data['title'] = this.title;
    data['airing'] = this.airing;
    data['synopsis'] = this.synopsis;
    data['type'] = this.type;
    data['episodes'] = this.episodes;
    data['score'] = this.score;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['members'] = this.members;
    data['rated'] = this.rated;
    return data;
  }
}
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:statemanagement/api7.dart';

class api6 extends StatefulWidget {
  const api6({Key? key}) : super(key: key);

  @override
  _api6State createState() => _api6State();
}

class _api6State extends State<api6> {

  getAllData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List list = jsonDecode(response.body);


    List<api_6> api_2list = list.map((e) => api_6.fromJson(e)).toList();

    return api_2list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("API 6"),
        actions: [
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return api7();
            },));
          }, child: Text("go to next",style: TextStyle(fontSize: 22,color: Colors.black)),)
        ],
      ),
      body: FutureBuilder(
        future: getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<api_6> list = snapshot.data as List<api_6>;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(4),
                    child: ListTile(
                      tileColor: Colors.black12,
                      leading: Text(
                        "${list[index].id}",
                        style: TextStyle(fontSize: 22),
                      ),
                      title: Text("${list[index].title}",
                          style: TextStyle(fontSize: 22)),
                      subtitle: Text("${list[index].completed}",
                          style: TextStyle(fontSize: 22)),
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
class api_6 {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  api_6({this.userId, this.id, this.title, this.completed});

  api_6.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:statemanagement/api4.dart';


class api3 extends StatefulWidget {
  const api3({Key? key}) : super(key: key);

  @override
  _api3State createState() => _api3State();
}

class _api3State extends State<api3> {

  getAllData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List list = jsonDecode(response.body);


    List<api_3> api_2list = list.map((e) => api_3.fromJson(e)).toList();

    return api_2list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("API 3"),
        actions: [
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return api4();
            },));
          }, child: Text("go to next",style: TextStyle(fontSize: 22,color: Colors.black)),)
        ],
      ),
      body: FutureBuilder(
        future: getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<api_3> list = snapshot.data as List<api_3>;
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
                      title: Text("${list[index].name}",
                          style: TextStyle(fontSize: 22)),
                      subtitle: Text("${list[index].email}\n""${list[index].body}",
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

class api_3 {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  api_3({this.postId, this.id, this.name, this.email, this.body});

  api_3.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}

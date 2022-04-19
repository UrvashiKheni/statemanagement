import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:http/http.dart' as http;
import 'package:statemanagement/api2.dart';

class api1 extends StatefulWidget {
  const api1({Key? key}) : super(key: key);

  @override
  _api1State createState() => _api1State();
}

class _api1State extends State<api1> {
  getAllData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List list = jsonDecode(response.body);

    // List<api_1> api_1list = [];
    //
    // for(int i=0;i<list.length;i++)
    //   {
    //     api_1 api_1 = api_1.fromJson(list[i]);
    //     api_1list.add(api_1);
    //   }

    List<api_1> api_1list = list.map((e) => api_1.fromJson(e)).toList();

    return api_1list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("API 1"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return api2();
                },
              ));
            },
            child: Text("go to next",
                style: TextStyle(fontSize: 22, color: Colors.black)),
          )
        ],
      ),
      body: FutureBuilder(
        future: getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<api_1> list = snapshot.data as List<api_1>;
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
                      subtitle: Text("${list[index].body}",
                          style: TextStyle(fontSize: 22)
                      ),
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

class api_1 {
  int? userId;
  int? id;
  String? title;
  String? body;

  api_1({this.userId, this.id, this.title, this.body});

  api_1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

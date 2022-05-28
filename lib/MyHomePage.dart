import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<List<dynamic>> controller = StreamController();

  getdata() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));

    var data = jsonDecode(response.body);

    controller.sink.add(data);
    print(data.length);
  }

  

  postData() async {
    var data = {"userId": 411, "title": "delectus aut autem", "body": "bar"};

    var response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode(data),
        headers: {"content-type": "application/json; charset=UTF-8"});

    print(response.body);
  }

  DeleteData() async {
    var response = await http
        .delete(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
    print(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: (snapshot.data as dynamic).length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Text((snapshot.data as dynamic)[index]
                                    ["id"]
                                .toString()),
                            title: Text(
                                (snapshot.data as dynamic)[index]["title"]),
                          );
                        },
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    getdata();
                  },
                  child: Text("Get Data"),
                ),
                TextButton(
                  onPressed: postData,
                  child: Text("Post Data"),
                ),
                TextButton(
                  onPressed: DeleteData,
                  child: Text("Delete Data"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

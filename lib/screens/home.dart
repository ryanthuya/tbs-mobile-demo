import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tbs_mobile_demo/models/book.dart';
import 'dart:convert';
import 'dart:async';

import '../env.api.dart';
import '../models/student.dart';
import 'create.dart';
import 'details.dart';

class Home extends StatefulWidget {
  // const Homepage({Key? key}) : super(key: key);
  const Home({Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<Student>> students;
  final studentListKey = GlobalKey<HomeState>();

  late Future<List<Book>> books;

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    students = getStudentList();
    //Firebase Token
    // _firebaseMessaging.getToken().then((token) => print(token));
  }


  Future<List<Student>> getStudentList() async {
    
    Response responseBooks;
    var dio = Dio();
    responseBooks = await dio.get('https://api.todaybooks.com.mm/api/books/');
    print(responseBooks.data.toString());
    // Optionally the request above could also be done as
    // response = await dio.get('/test', queryParameters: {'id': 12, 'name': 'wendu'});
    print(responseBooks.data.toString());

    await Future.delayed(const Duration(seconds: 1));
    // Load Json Data
    final response = await http.get(Uri.parse(Env.url_prefix));
    print(response.body.toString());

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    
    List<Student> students = items.map<Student>((json) {
      return Student.fromJson(json);
    }).toList();
    return students;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: studentListKey,
      appBar: AppBar(
        title: const Text('Students List'),
      ),
      body: Center(
        child: FutureBuilder<List<Student>>(
          future: students,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return const CircularProgressIndicator();
            // Render student lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.view_list),
                    title: Text(
                      data.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Details(student: data)),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
         onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Create()),
          );
         },
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:tbs_mobile_demo/env.api.dart';
import 'package:tbs_mobile_demo/models/book.dart';
import 'dart:convert';
import 'dart:async';
import 'details.dart';

class Home extends StatefulWidget {
  // const Homepage({Key? key}) : super(key: key);
  const Home({Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<Book>> books;
  final bookListKey = GlobalKey<HomeState>();

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    books = getBookList();

    //Firebase Token
    // _firebaseMessaging.getToken().then((token) => print(token));
  }
  Future<List<Book>> getBookList() async {
    await Future.delayed(const Duration(seconds: 1));
    // Load Json Data
    final response = await http.get(Uri.parse(Env.books_api_url));
    final items = json.decode(response.body)['books']['data'].cast<Map<String, dynamic>>();
    List<Book> books = items.map<Book>((json) {
      return Book.fromJson(json);
    }).toList();

    if (kDebugMode) {
      print(items);
    }
    return books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: bookListKey,
      appBar: AppBar(
        title: const Text('Popular Books List'),
      ),
      body: Center(
        child: FutureBuilder<List<Book>>(
          future: books,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return const CircularProgressIndicator();
            // Render book lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child:GFListTile(
                      avatar:GFAvatar(
                          backgroundImage:NetworkImage(data.slug),
                          shape: GFAvatarShape.standard
                      ),
                      titleText:data.title,
                      subTitleText:data.desc.substring(0, 55)+" ...",

                    icon: Icon(Icons.view_list_rounded),
                      onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Details(book: data)),
                          );
                        },
                  )
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
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
  const Home({Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
  //State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<Book>> books;
  final bookListKey = GlobalKey<HomeState>();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;


  Future<void> setupInteractedMessage() async {
    //Firebase Token
    messaging.getToken().then((token) => print(token));

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message id: ${message.messageId}');


      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        print('Message also contained a notification: ${message.notification?.body.toString()}');
      }
    });
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);

    }
    // Also handle any interaction when the app is in the background via a
    // Stream listener

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      Navigator.pushNamed(context, '/chat',
        arguments: (message),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    books = getBookList();
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


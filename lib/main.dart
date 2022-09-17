import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tbs_mobile_demo/models/student.dart';
import 'package:tbs_mobile_demo/screens/books/home.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

handleNotifications() async {
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(badge: true, alert: true, sound: true);
  //presentation options for Apple notifications when received in the foreground.

  FirebaseMessaging.onMessage.listen((message) async {
    print('Got a message whilst in the FOREGROUND!');
    return;
  }).onData((data) {
    print('Got a DATA message whilst in the FOREGROUND!');
    print('data from stream: ${data.data}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    print('NOTIFICATION MESSAGE TAPPED');
    return;
  }).onData((data) {
    print('NOTIFICATION MESSAGE TAPPED');
    print('data from stream: ${data.data}');
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((value) => value != null ? _firebaseMessagingBackgroundHandler : false);
  return;
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  handleNotifications();
  runApp(const App());
}

late final Student student;
//
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodayBookStore(DEMO)',
      initialRoute: '/',
        theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // home: const Home(),
      routes: {
        '/': (context) => const Home(),
        // '/create': (context) => const Create(),
        // '/edit': (context) => Edit(student:student),
      },
    );
  }
}
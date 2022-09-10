import 'package:flutter/material.dart';
import 'package:tbs_mobile_demo/models/student.dart';
import 'package:tbs_mobile_demo/screens/books/home.dart';
import 'package:tbs_mobile_demo/screens/students/create.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}


late final Student student;
//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/create': (context) => const Create(),
        // '/edit': (context) => Edit(student:student),
      },
    );
  }
}
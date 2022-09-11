import 'package:flutter/material.dart';
import 'package:tbs_mobile_demo/models/student.dart';
import 'package:tbs_mobile_demo/screens/books/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
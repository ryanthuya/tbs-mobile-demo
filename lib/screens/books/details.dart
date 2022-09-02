import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import '../env.api.dart';
import '../models/book.dart';
import './edit.dart';

class Details extends StatefulWidget {
  Book book;
  Details({Key? key, required this.book}) : super(key: key);
  // Details(required this.student}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void deleteStudent(context) async {
    await http.delete(
      //Uri.parse(Env.URL_PREFIX+"delete"),
      Uri.parse(Env.books_api_url+widget.book.id.toString()),
      body: {
        'id': widget.book.id.toString(),
      },
    );
    // Navigator.pop(context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Are you sure you want to delete this?'),
          actions: <Widget>[
            GFButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.cancel),
            ),
            GFButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () => deleteStudent(context),
              child: const Icon(Icons.check_circle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => confirmDelete(context),
          ),
        ],
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Name : ${widget.book.title}",
              style: const TextStyle(fontSize: 20),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Age : ${widget.book.desc}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Age : ${widget.book.price}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
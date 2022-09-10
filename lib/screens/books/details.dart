import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import 'package:tbs_mobile_demo/env.api.dart';
import 'package:tbs_mobile_demo/models/book.dart';

class Details extends StatefulWidget {
  Book book;
  Details({Key? key, required this.book}) : super(key: key);

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
          content: const Text('Are you sure you add to cart this book?'),
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
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () => confirmDelete(context),
          ),
        ],
      ),
      body: Container(
         height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.book.title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                widget.book.published_at,
                style: const TextStyle(
                    fontSize: 10,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              GFImageOverlay(
                  height: 210,
                  width: 320,
                  image: NetworkImage(widget.book.slug)
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                " ${widget.book.desc} ",
                style: const TextStyle(fontSize: 14),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                "${widget.book.price} MMK",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
              GFButton(
                onPressed: (){
                    GFToast.showToast("Buy Now Feature isn't availabile in this  version ", context);
                },
                text: "BUY NOW",
                icon: Icon(Icons.payment),
                type: GFButtonType.outline2x,
              ),
            ],
          ),
        ),

      ),
    );
  }
}
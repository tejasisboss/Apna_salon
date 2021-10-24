import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';

class BookedList extends StatefulWidget {
  BookedList({Key key}) : super(key: key);

  @override
  _BookedListState createState() => _BookedListState();
}

class _BookedListState extends State<BookedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
          indent: 10.0,
          endIndent: 10.0,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Name #$index'),
            subtitle: Text('Service'),
            trailing: Text("cost"),
          );
        },
      ),
    );
  }
}

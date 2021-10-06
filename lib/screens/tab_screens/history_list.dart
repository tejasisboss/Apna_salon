import 'package:flutter/material.dart';

class BookingHistoryList extends StatefulWidget {
  BookingHistoryList({Key key}) : super(key: key);

  @override
  _BookingHistoryListState createState() => _BookingHistoryListState();
}

class _BookingHistoryListState extends State<BookingHistoryList> {
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

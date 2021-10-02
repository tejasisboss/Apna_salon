import 'package:flutter/material.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({Key key}) : super(key: key);

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
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
            title: Text('Reviews #$index'),
            leading: Icon(Icons.message),
            trailing: IconButton(
              icon: Icon(Icons.reply),
              onPressed: () {
                //To Delete
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InsideList extends StatefulWidget {
  InsideList({Key key}) : super(key: key);

  @override
  _InsideListState createState() => _InsideListState();
}

class _InsideListState extends State<InsideList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
          indent: 10.0,
          endIndent: 10.0,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Service #$index'),
            subtitle: Text('Cost'),
            leading: Icon(Icons.person),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                //To Delete
              },
            ),
          );
        },
      ),
      floatingActionButton: addbutton(),
    );
  }
}

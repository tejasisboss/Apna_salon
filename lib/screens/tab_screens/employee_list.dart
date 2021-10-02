import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key key}) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
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
            title: Text('Employee #$index'),
            subtitle: Text('Post'),
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

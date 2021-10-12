import 'package:apna_salon/widgets/inside_list.dart';
import 'package:apna_salon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key key}) : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    void _showservicelist() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: InsideList(),
            );
          });
    }

    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
          indent: 10.0,
          endIndent: 10.0,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Section #$index'),
            leading: Icon(Icons.person),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                //To Delete
              },
            ),
            onTap: () {
              _showservicelist();
            },
          );
        },
      ),
      floatingActionButton: addbutton(),
    );
  }
}

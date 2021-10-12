import 'package:flutter/material.dart';

class PaymentsScreen extends StatefulWidget {
  PaymentsScreen({Key key}) : super(key: key);

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('Apna Salon'),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: (size.width * 0.03),
              vertical: (size.height * 0.01),
            ),
            child: Text(
              '5',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
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

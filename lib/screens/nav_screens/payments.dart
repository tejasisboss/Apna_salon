import 'package:apna_salon/screens/notifications.dart';
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
          GestureDetector(
            onTap: () {
              print('notifications');
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsList()));
            },
            child: Icon(
              Icons.notifications,
              size: 32,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: (size.width * 0.03),
              vertical: (size.height * 0.018),
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

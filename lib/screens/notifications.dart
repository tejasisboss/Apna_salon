import 'package:flutter/material.dart';

class NotificationsList extends StatefulWidget {

  @override
  _NotificationsListState createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notifications'),

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
          );
        },
      ),
    );
  }
}
